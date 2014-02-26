CREATE KEYSPACE applications
  WITH replication = {'class': 'SimpleStrategy', 'replication_factor' : 1};

USE applications;

CREATE TABLE events (
  app_id uuid,
  created_at timeuuid,
  event text,
  PRIMARY KEY (app_id, created_at)
);