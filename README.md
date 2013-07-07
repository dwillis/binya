# Binya

Binya is a Ruby library for parsing information from Federal Reserve sites. Its initial utility is to parse [a listing of speeches, testimony and other comments](http://www.stlouisfed.org/fomcspeak/date.aspx) by Federal Open Market Committee participants and return Ruby objects. It also provides details about the FOMC participants via a YAML file that can be loaded. More examples and explanations in [the docs](http://dwillis.github.io/binya).

Binya is named for [Binyamin Applebaum](http://topics.nytimes.com/top/reference/timestopics/people/a/binyamin_appelbaum/index.html), a Washington correspondent for The New York Times.

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

# scrapes http://www.stlouisfed.org/fomcspeak/date.aspx
results = Binya::Remarks.fetch_html
puts results.first
=> <Binya::Remarks:0x007f987b8f2dc8 @date=#<Date: 2013-07-02 ((2456476j,0s,0n),+0s,2299161j)>, @time=2013-07-02 17:45:00 -0400, @participant="Jerome H. Powell", @participant_id=22, @type="Speech", @location="The University Club, New York, N.Y.", @title="International Financial Regulatory Reform ", @url="http://www.federalreserve.gov/newsevents/speech/powell20130702a.htm">

# pulls from rss feeds of FOMC participants - this puts type, location and title into a single field
latest_from_rss = Binya::Remarks.latest

# loads the FOMC participants
fomc = Binya::Participant.load_all
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
