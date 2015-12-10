# SftpListen

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/sftp_listen`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sftp_listen'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sftp_listen

## Usage

### Generate rsa and dsa keys
ssh-keygen -t rsa -f keys/rsa_key
ssh-keygen -t dsa -f keys/dsa_key

### Create a Listener
```ruby
class MyListener
  def perform(modified, added, removed)
    puts "modified = #{modified}"
    puts "added = #{added}"
    puts "removed = #{removed}"
  end
end
```

### Add an Initializer
```ruby
SftpListen.configure do |config|
  config.handler_klass = MyListener
  config.directories = ["sftp_files/inbound", "sftp_files/outbound"]
  config.user_name = 'listen_test'
  config.password = 'listen_test'
  config.port = '2299'

  config.rsa_key = File.expand_path('../keys/rsa_key', __FILE__)
  fail "could not find rsa key file: #{config.rsa_key}" unless File.exist?(config.rsa_key)

  config.dsa_key = File.expand_path('../keys/dsa_key', __FILE__)
  fail "could not find dsa key file: #{config.dsa_key}" unless File.exist?(config.dsa_key)
end
```

### Create and start the listener
```ruby
sftp_listener = SftpListen::SftpListener.new
sftp_listener.start
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/slabounty/sftp_listen.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

