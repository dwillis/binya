require 'open-uri'
module Binya
  
  class Scraper
    
    attr_reader :date, :time, :speaker, :type, :location, :title, :url
    
    def initialize(params={})
      params.each_pair do |k,v|
       instance_variable_set("@#{k}", v)
      end
    end
    
    def fetch!
      url = "http://www.stlouisfed.org/fomcspeak/date.aspx"
      doc = Nokogiri::HTML(open(url).read)
      (doc/:table)[1].children[2..26].each do |row|
        
        
      end
      
    end
    
    
  end
  
  
end