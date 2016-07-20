# DotLoop API Library

This library is designed to help ruby applications consume the DotLoop API.

You can read more about the api the the official documentation at [https://support.dotloop.com](https://support.dotloop.com/hc/en-us/articles/204407013-Dotloop-REST-API-Developer-s-Guide)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dotloop'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dotloop

## Usage
    Dotloop::Client.new(api_key: 'c4c26918-b2df-49a6-9bc2-9009274b23a7')
    client.Profile.all

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dotloop.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
