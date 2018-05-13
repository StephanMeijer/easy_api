# EasyApi

EasyApi is a library to use to write easy API clients with.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'easy_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install easy_api

## Usage

Example usage of Telegram API:
```ruby
class PhotoSize < EasyApi::Object
  def required_attribute_names
    [:file_id, :width, :height,]
  end
  def optional_attribute_names
    [:file_size]
  end
end

class Video < EasyApi::Object
  def required_attribute_names
    [:file_id, :width, :height, :duration]
  end
  def optional_attribute_names
    [:thumb, :mime_type, :file_size]
  end
  def schema
    {thumb: PhotoSize}
  end
end

Video.new(
  file_id: "abc123",
  width: 720,
  height: 480,
  duration: 123,
  thumb: {
    file_id: "123abc",
    width: 128,
    height: 76,
    file_size: 123123123
  },
  file_size: 123445
)
```

Outputs:
```
#<Video:0x00007fac3f2ac450 @attributes={:file_id=>"abc123", :width=>720, :height=>480, :duration=>123, :thumb=>#<PhotoSize:0x00007fac3f2ade40 @attributes={:file_id=>"123abc", :width=>128, :height=>76, :file_size=>123123123}>, :file_size=>123445}>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test\\` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/StephanMeijer/easy_api.
