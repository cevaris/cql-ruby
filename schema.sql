CREATE KEYSPACE eventsks 
  WITH replication = {'class': 'SimpleStrategy', 'replication_factor' : 1};

USE eventsks;

CREATE TABLE events (
  id uuid PRIMARY KEY,
  app_id uuid,
  created_at timestamp,
  event text
);