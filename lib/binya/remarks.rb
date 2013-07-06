require 'open-uri'
require 'nokogiri'
require 'american_date'
require 'typhoeus'
module Binya
  
  class Remarks
    
    attr_accessor :date, :time, :participant, :participant_id, :type, :location, :title, :url, :text
    
    def initialize(params={})
      params.each_pair do |k,v|
       instance_variable_set("@#{k}", v)
      end
    end

    def self.create(params={})
      self.new :date => params[:date],
        :time => params[:time],
        :participant => params[:participant],
        :participant_id => params[:participant_id],
        :type => params[:type],
        :location => params[:location],
        :title => params[:title],
        :url => params[:url]
    end

    def self.latest
      results = []
      participants = Participant.load_all
      hydra = Typhoeus::Hydra.new
      participants.each do |participant|
        req = Typhoeus::Request.new(participant.rss_url)
        req.on_complete do |response|
          if response.success?
            doc = Nokogiri::XML(response.body)
            results << parse_rss(doc, participant)
          end
        end
        hydra.queue(req)
      end
      hydra.run
      results.flatten
    end

    def self.parse_rss(doc, participant)
      links = doc.xpath('//item')
      links.map do |link|
        Remarks.create({:date => Date.parse(link.xpath('pubDate').text), :participant => participant.name, :participant_id => participant.fomc_id, :title => link.xpath('title').text, :url => link.xpath('link').text})
      end
   end

   def self.fetch_html
      results = []
      url = "http://www.stlouisfed.org/fomcspeak/date.aspx"
      doc = Nokogiri::HTML(open(url).read)
      (doc/:table)[1].children[2..26].each do |row|
        date = Date.parse(row.children[0].children[0].text)
        time = row.children[0].children.size == 1 ? nil : Time.parse(row.children[0].children[2].text, date)
        results << {:date => date, :time => time, :speaker => row.children[1].text, :type => row.children[2].text, 
          :location => row.children[3].text.strip, :title => row.children[4].text.strip, :url => row.children[4].children[0]['href']}
      end
      results.map{|r| Remarks.create(r)}
    end
  end
end