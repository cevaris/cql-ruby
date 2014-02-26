#!/usr/bin/env ruby

require 'cassandra-cql'
require 'json'
require 'optparse'
require 'tweetstream'


def connect_db
	CassandraCQL::Database.new('192.168.3.100:9160')
end

def connect_twitter
	creds = JSON.parse(File.read("credentials.json"))

	TweetStream.configure do |config|
	  config.consumer_key       = creds['consumer_key']
	  config.consumer_secret    = creds['consumer_secret']
	  config.oauth_token        = creds['oauth_token']
	  config.oauth_token_secret = creds['oauth_token_secret']
	  config.auth_method        = :oauth
	end

end


def execute
	TweetStream::Client.new.sample do |status|
	  payload = { events: status, app: { id: app.uuid } }.to_json    
	  puts payload
	end
end





if __FILE__ == $0

  options = {}

  optparse = OptionParser.new do|opts|
    opts.banner = "Usage: cql-ruby.rb [options]"

    options[:verbose] = false
      opts.on( '-v', '--verbose', 'Output more information' ) do
      options[:verbose] = true
    end

    # options[:event] = 'Boulder flash floods 2013'
    # opts.on( '-e', '--event EVENT_NAME', 'Name of event which to output keywords' ) do|value|
    #   options[:event] = value
    # end

    opts.on( '-h', '--help', 'Display this screen' ) do
      puts opts
      exit
    end
  end

  optparse.parse!

  connect_db()
  connect_twitter()

  execute()
end
