require 'open-uri'
module Binya
  
  class Remarks
    
    attr_reader :date, :time, :speaker, :type, :location, :title, :url, :text
    
    def initialize(params={})
      params.each_pair do |k,v|
       instance_variable_set("@#{k}", v)
      end
    end

    def self.create(params={})
      self.new :date => params[:date],
        :time => params[:time],
        :speaker => params[:speaker],
        :type => params[:type],
        :location => params[:location],
        :title => params[:title],
        :url => params[:url],
        :text => params[:text]
    end

    def self.fetch!
      results = []
      url = "http://www.stlouisfed.org/fomcspeak/date.aspx"
      doc = Nokogiri::HTML(open(url).read)
      (doc/:table)[1].children[2..26].each do |row|
        date = Date.parse(row.children[0].children[0].text)
        results << {:date => date, :time => Time.parse(row.children[0].children[2].text, date), 
          :speaker => row.children[1].text, :type => row.children[2].text, :location => row.children[3].text,
          :title => row.children[4].text.strip, :url => row.children[4].children[0]['href'], :text => Remarks.get_text(row.children[4].children[0]['href'])}
      end
      results.map{|r| Remarks.create(r)}
    end
    
    def self.get_text(url)
      doc = Nokogiri::HTML(open(url).read)
      (doc/:p).map{|p| p.text.strip}[1..-7].join(' ')
    end

    
  end
  
  
end