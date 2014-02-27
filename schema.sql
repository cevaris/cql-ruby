CREATE KEYSPACE applications
  WITH replication = {'class': 'SimpleStrategy', 'replication_factor' : 1};

USE applications;

-- CREATE TABLE events (
--   id timeuuid,
--   bucket text,
--   app_id uuid,
--   event text,
--   PRIMARY KEY(id, bucket)
-- );

-- CREATE INDEX events_app_id ON events(app_id);

CREATE TABLE events (
  id timeuuid PRIMARY KEY,
  app_id uuid,
  bucket text,
  event text,
);

CREATE INDEX events_app_id ON events(app_id);
CREATE INDEX events_on_bucket ON events(bucket);