# Latergram

Latergram API Client

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'latergram'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install latergram

## Usage

### API Client

```ruby
api = Latergram::Api.new(api_key)
```

### Social Posts

#### Create a social post

```ruby
api.social_posts.create(
  text: "example text",
  image_urls: [url1, url2]
)
```

Response:

```ruby
{
  'data' => {
    'id' => '99',
    'type' => 'social_post',
    'attributes' => {
      'text' => 'example text',
      'created_at' => '2019-10-30T23:54:12.147+01:00',
      'updated_at' => '2019-10-30T23:54:12.192+01:00',
      'status' => 'new',
      'published_at' => '2045-06-01T12:05:00.000+01:00'
    }
  }
}
```

#### Update a social post

```ruby
api.social_posts.update(99, text: 'another text')
```

Response:

```ruby
{
  'data' => {
    'id' => '99',
    'type' => 'social_post',
    'attributes' => {
      'text' => 'another text',
      'created_at' => '2019-10-30T23:54:12.147+01:00',
      'updated_at' => '2019-10-31T00:01:58.128+01:00',
      'status' => 'new',
      'published_at' => '2045-06-01T12:05:00.000+01:00'
    }
  }
}
```

#### Destroy a social post

```ruby
api.social_posts.destroy(99)
```

Response:

```ruby
{
  'data' => {
    'id' => '99',
    'type' => 'social_post',
    'attributes' => {
      'text' => 'another text',
      'created_at' => '2019-10-30T23:54:12.147+01:00',
      'updated_at' => '2019-10-31T00:03:30.973+01:00',
      'status' => 'to_be_deleted',
      'published_at' => '2045-06-01T12:05:00.000+01:00'
    }
  }
}
```

#### List all social posts

```ruby
api.social_posts.all(page: 1, per_page: 10)
```

Response:

```ruby
{
  'data' => [
    {
      'id' => '98',
      'type' => 'social_post',
      'attributes' => {
        'text' => 'test1',
        'created_at' => '2019-10-30T20:54:14.960+01:00',
        'updated_at' => '2019-10-30T20:54:15.011+01:00',
        'status' => 'new',
        'published_at' => '2019-10-30T20:59:14.000+01:00'
      }
    },
    # ...
    {
      'id' => '95',
      'type' => 'social_post',
      'attributes' => {
        'text' => 'test2',
        'created_at' => '2019-10-29T22:46:35.857+01:00',
        'updated_at' => '2019-10-29T23:46:41.645+01:00',
        'status' => 'published',
        'published_at' => '2019-10-29T23:46:35.000+01:00'
      }
    }
  ],
  'links' => {
    'first' => 'http://localhost/api/social_posts?page=1&per_page=10',
    'last' => 'http://localhost/api/social_posts?page=26&per_page=10',
    'next' => 'http://localhost/api/social_posts?page=2&per_page=10'
  },
  'meta' => { 'total' => 51 }
}
```

#### Find one social post

```ruby
api.social_posts.find(95)
```

Response:

```ruby
{
  'data' => {
    'id' => '95',
    'type' => 'social_post',
    'attributes' => {
      'text' => 'test2',
      'created_at' => '2019-10-29T22:46:35.857+01:00',
      'updated_at' => '2019-10-29T23:46:41.645+01:00',
      'status' => 'published',
      'published_at' => '2019-10-29T23:46:35.000+01:00'
    }
  }
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Latergram/latergram_ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
