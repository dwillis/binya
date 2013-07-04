require 'rubygems'
require 'binya'
include Binya
require 'minitest/autorun'

class TestRemarks < MiniTest::Unit::TestCase

	def setup
		@results = Remarks.fetch!
	end

	def test_that_there_are_25_results
		assert_equal 25, @results.size
	end
end