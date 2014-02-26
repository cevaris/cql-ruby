#!/usr/bin/env ruby

require 'thread'
require 'cassandra-cql'
require 'json'
require 'optparse'
require 'tweetstream'
require 'securerandom'

def connect_db
  CassandraCQL::Database.new('127.0.0.1:9160')
end

def insert_event(args)
  %{INSERT INTO eventsks.events 
    (id, app_id, created_at, event) 
    VALUES (#{args[:id]}, #{args[:app_id]}, #{args[:created_at]}, #{args[:event]})};

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

  db = connect_db()

  apps = ['4fcd0582-7798-46ac-8ae3-df7ce7890b79','8a0bb010-bb38-4667-8c37-471efef24993', 'c389039d-1480-499b-86f6-808d3f17ef27']
  TweetStream::Client.new.sample do |status|

    begin
      args = {}
      args[:app_id] = apps.sample
      args[:created_at] = Time.new
      args[:event] = status.attrs.to_json
      args[:id]  = SecureRandom.uuid
      db.execute(insert_event(args))

    rescue Exception => e
      puts e
    end

  end

end





if __FILE__ == $0

  # STDOUT.sync = true
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

  
  connect_twitter()
  execute()
end
