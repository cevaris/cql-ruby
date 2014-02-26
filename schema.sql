CREATE KEYSPACE apps WITH
     strategy_class = 'SimpleStrategy'
     AND strategy_options:replication_factor = '1';

USE apps;

CREATE TABLE events (
  id uuid PRIMARY KEY,
  created_at string,
  event text
);