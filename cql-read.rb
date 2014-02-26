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

def get_events(args)
  %{SELECT * FROM eventsks.events 
    WHERE app_id = #{args[:app_id]}
    ORDER BY created_at desc 
    LIMIT 10;}
end

def execute

  db = connect_db()
  args = {}
  args[:app_id] = '4fcd0582-7798-46ac-8ae3-df7ce7890b79'
  db.execute(get_events())

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


  execute()
end
