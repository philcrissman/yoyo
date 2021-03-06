# Yoyo

A ruby gem for using the YO API. You know you need this.

[![Build Status](https://travis-ci.org/philcrissman/yoyo.svg)](https://travis-ci.org/philcrissman/yoyo)

## Installation

Add this line to your application's Gemfile:

    gem 'yoyo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yoyo

## Usage

You'll need to get an API token from [YO](http://yoapi.justyo.co/). You go ahead and do that, I'll wait.

```
yo = Yoyo::Yo.new(api-key)

# YO some specific YO user
yo.yo("SOME_YO_USER")

# mass YO everyone who has ever YO'd your API account
yo.yo_all

# find out how many subscribers you have. OMG
yo.subscribers_count
```

That's ... that's pretty much their entire API

## Why would I install this gem instead of just using `curl`?

Only you can answer this question.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/yoyo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
