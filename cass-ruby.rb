#!/usr/bin/ruby

require 'cassandra-cql'
require 'json'


def connect_db
	db = CassandraCQL::Database.new('192.168.3.100:9160')
end

def connect_twitter
	creds = JSON.parse(File.read("#{Rails.root}/.credentials.json"))

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
	end
end



