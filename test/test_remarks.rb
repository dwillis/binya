require 'rubygems'
require 'binya'
require 'open-uri'
require 'nokogiri'
require 'minitest/autorun'
require 'webmock/minitest'

class TestRemarks < MiniTest::Test

	def setup
		stub_request(:any, "www.stlouisfed.org/fomcspeak/date.aspx").to_return(:body => File.open("test/fomcspeak.html").read, :status => 200)
		@response = Net::HTTP.get('www.stlouisfed.org', '/fomcspeak/date.aspx')
		@doc = Nokogiri::HTML(@response)
		@results = []
		(@doc/:table)[1].children[2..26].each do |row|
	        date = Date.parse(row.children[0].children[0].text)
	        time = row.children[0].children.size == 1 ? nil : Time.parse(row.children[0].children[2].text, date)
	        @results << {:date => date, :time => time, :speaker => row.children[1].text, :type => row.children[2].text, 
	          :location => row.children[3].text.strip, :title => row.children[4].text.strip, :url => row.children[4].children[0]['href']}
        end
        @remarks = @results.map{|r| Binya::Remarks.create(r)}
	end

	def test_that_there_are_25_results
		assert_equal 25, @results.size
	end

	def test_that_binya_creates_remarks_object
		assert_equal "Gov. Powell", @remarks.first.speaker
	end

end