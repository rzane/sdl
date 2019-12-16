# SDL

SDL is generic schema definition language.

Alone, it doesn't do anything useful. However, you might find it to be helpful
for the purpose of code generation.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sdl'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sdl

## Examples

### Define a schema

```ruby
SDL.define do
  model :user do
    attribute :email, :string, required: true, unique: true
    has_many :posts
    timestamps
  end

  model :post do
    attribute :title, :string, limit: 120, required: true
    attribute :body, :text
    enum :status, values: [:draft, :published]
    belongs_to :user, foreign_key: true
    has_one_attached :image
    timestamps
  end
end
```

### Load a schema from a file

```ruby
SDL.load_file "schema.rb"
```

### Parse command-line arguments

```ruby
SDL.parse "user", %w[
  email:required:unique
  posts:has_many
]

SDL.parse "post", %w[
  title:string{120}:required
  body:text
  status:enum{draft,published}
  user:belongs_to:foreign_key
  image:has_one_attached
]
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rzane/sdl. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SDL project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/rzane/sdl/blob/master/CODE_OF_CONDUCT.md).
