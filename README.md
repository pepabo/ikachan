# Ikachan

[![Gem Version](https://badge.fury.io/rb/ikachan.png)](http://badge.fury.io/rb/ikachan)
[![Build Status](https://travis-ci.org/paperboy-all/ikachan.png?branch=master)](https://travis-ci.org/paperboy-all/ikachan)

Ruby wrapper of Ikachan

## Installation

Add this line to your application's Gemfile:

    gem 'ikachan'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ikachan

## Usage

```ruby
Ikachan.url = "http://irc.example.com:4649"
Ikachan.channel = "#example"
Ikachan.notice 'awesome comment'
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ikachan/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
