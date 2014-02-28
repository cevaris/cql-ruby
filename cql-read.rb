#!/usr/bin/env ruby

require 'thread'
require 'cql'
require 'json'
require 'optparse'
require 'tweetstream'
require 'securerandom'

def connect_db
  Cql::Client.connect()
end

def get_events(args)
  %{SELECT id, bucket, app_id FROM applications.events 
  WHERE bucket = '#{args[:bucket]}' 
    AND id >= minTimeuuid('#{args[:start]}+0000') 
    AND id <  maxTimeuuid('#{args[:end]}+0000');}
  # SELECT * FROM applications.events 
  #   WHERE app_id = #{args[:app_id]}
  #   ORDER BY created_at DESC 
  #   LIMIT 10;}
end

def execute

  db = connect_db()
  args = {}
  args[:app_id] = '4fcd0582-7798-46ac-8ae3-df7ce7890b79'
  args[:bucket] = '2014-02-28-02'
  args[:start]  = '2014-02-28 02:00:00'
  args[:end]    = '2014-02-28 02:05:00'
  # puts get_events(args)
  rows = db.execute(get_events(args))
  puts rows.inspect
  rows.each do |row|
    puts "#{row['app_id']} - #{row['id']} - #{row['bucket']}"
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


  execute()
end
