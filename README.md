# DotLoop API Library
[![Build Status](https://travis-ci.org/Loft47/dotloop.svg?branch=master)](https://travis-ci.org/Loft47/dotloop)
[![Coverage Status](https://coveralls.io/repos/github/Loft47/dotloop/badge.svg?branch=master&renew=true)](https://coveralls.io/github/Loft47/dotloop?branch=master)

This library is designed to help ruby applications consume the DotLoop API.

You can read more about the api from the official documentation at [https://support.dotloop.com](https://support.dotloop.com/hc/en-us/articles/204407013-Dotloop-REST-API-Developer-s-Guide)

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

Optional parameters are prefixed with a __'*'__'

```ruby
    client = Dotloop::Client.new(api_key: 'c4c26918-b2df-49a6-9bc2-9009274b23a7')

    client.Profile.all                                                      #=> get list of profiles

    client.Loop.all(
      profile_id: '1234',
      *batch_number: 1,
      *batch_size: 50,
      *statusIds: '1,2,3'
      *complianceStatusIds: '1,2,3'
      *tagIds: '1,2,3'
      *sortBy: 'email'
      *searchQuery: 'test@example.com'
      *tagNames: 'tag'
      *createdByMe: '1234567'
    )                                                                       #=> get list of loops

    client.Loop.all(profile_id: '1234', loop_view_id: '76046')              #=> get basic loop information

    client.Loop.find(profile_id: '1234', loop_view_id: '76046')             #=> get loop details
    client.LoopActivity.all(
      profile_id: '1234',
      loop_view_id: '76046',
      *batch_number: 1,
      *batch_size: 50
    )                                                                       #=> get loop activity
    client.Document.all(profile_id: '1234', loop_view_id: '76046')          #=> get loop document list

    client.Participant.all(profile_id: '1234', loop_view_id: '76046')       #=> get a list of loop participants

    client.Task.all(profile_id: '1234', loop_view_id: '76046')              #=> get a list of loop tasks

    client.Folder.all(profile_id: '1234', loop_view_id: '76046')            #=> get a list of folders in a loop

    client.Employee.all(
      profile_id: '1234',
      *batch_number: 1,
      *batch_size: 50,
      *show_admin: true,
      *show_in_active: true,
      *include_child: true
    )                                                                       #=> get a list of users in a profile
    client.DocumentActivity.all(
      profile_id: '1234',
      document_id: '561622',
      *batch_number: 1,
      *batch_size: 50
    )                                                                       #=> get activity details for a document
    client.Person.all(
      profile_id: '1234',
      *batch_number: 1,
      *batch_size: 50
    )                                                                       #=> get list of contacts
    client.Person.find(profile_id: '1234', contact_id: '3603862')           #=> get details for a contact

    client.Admin.all(
      profile_id: '1234',
      *batch_number: 1,
      *batch_size: 50
    )                                                                       #=> get list of admins for a profile

    client.Document.get(
      profile_id: '1234',
      loop_view_id: '76046',
      document_id: '561622',
      document_name: 'My Offer'
    )                                                                       #=> get a PDF document
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dotloop.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
