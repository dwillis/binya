require 'yaml'
module Binya
  
  class Participant

  	attr_accessor :fomc_id, :name, :title, :term_start, :term_end, :rss_url, :img_url, :latest_remarks, :fomc_name

  	def initialize(params={})
      params.each_pair do |k,v|
       instance_variable_set("@#{k}", v)
      end
    end

    def self.create(params={})
    	self.new :fomc_id => params["fomcspeak"],
    		:name => params["name"],
    		:title => params["title"],
    		:term_start => params["term_start"],
    		:term_end => params["term_end"],
    		:rss_url => params["rss_url"],
    		:img_url => params["img_url"],
    		:fomc_name => params["fomc_name"]
    end

    def self.load_all
    	participants = YAML.load_file('participants.yml')
    	participants.map{|p| Participant.create(p)}
    end

    def latest_remarks
    	doc = Nokogiri::XML(open(rss_url).read)
    	Remarks.parse_rss(doc, self)
    end


  end
end
