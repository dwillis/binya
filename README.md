# Binya

Binya is a Ruby library for parsing information from Federal Reserve sites. Its initial utility is to parse [a listing of speeches, testimony and other comments](http://www.stlouisfed.org/fomcspeak/date.aspx) by Federal Open Market Committee participants and return Ruby objects.

Binya is tested under Ruby 1.9.3.

## Installation

Add this line to your application's Gemfile:

    gem 'binya'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install binya

## Tests

To run the tests, run `rake test`. Binya uses MiniTest.

## Usage

```ruby
require 'rubygems'
require 'binya'

results = Binya::Remarks.fetch!
puts results.first
<Binya::Remarks:0x007fc5f4996c88 @date=<Date: 2013-07-02 ((2456476j,0s,0n),+0s,2299161j)>, @time=2013-07-02 17:45:00 -0400, @speaker="Gov. Powell", @type="Speech", @location="The University Club, New York, N.Y.", @title="International Financial Regulatory Reform ", @url="http://www.federalreserve.gov/newsevents/speech/powell20130702a.htm">
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
