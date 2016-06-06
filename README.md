# ZEN ENV

Simple and flexible approach to loading environment variables.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zenv'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zenv

## Usage

Create a `.zenv` file at the root of your project:

```ruby
{
  default: {
    KEY: 'value',
    ...
  },
}
```

The `:default` namespace will be loaded into `ENV`.

### Namespaces

To load a different set of environment variables, add another "namespace":

```ruby
{
  default: {
    KEY: 'value',
    ...
  },
  other: {
    KEY: 'other value',
    ...
  }
}
```

Specify the namespace in `ZENV`. E.g. `ZENV=other rails console`.

### Pre-loading

If environment variables need to be loaded _before_ your application is loaded, run the command with `zenv`. For example, if you're running the puma web server and it depends on `PORT`, run `zenv puma`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/austinthecoder/zenv.
