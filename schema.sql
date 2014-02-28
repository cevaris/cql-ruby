CREATE KEYSPACE applications
  WITH replication = {'class': 'SimpleStrategy', 'replication_factor' : 1};

USE applications;

CREATE TABLE events(
  bucket text, 
  id timeuuid,
  app_id uuid,  
  event text, 
  PRIMARY KEY(bucket, id)
);

-- insert into events(bucket, id, event, app_id) VALUES ('13081615', now(), '90', 4fcd0582-7798-46ac-8ae3-df7ce7890b79);
-- insert into events(bucket, id, event, app_id) VALUES ('13081615', now(), '91', 4fcd0582-7798-46ac-8ae3-df7ce7890b79);
-- insert into events(bucket, id, event, app_id) VALUES ('13081615', now(), '92', 4fcd0582-7798-46ac-8ae3-df7ce7890b79);
-- insert into events(bucket, id, event, app_id) VALUES ('13081615', now(), '93', 4fcd0582-7798-46ac-8ae3-df7ce7890b79);
-- insert into events(bucket, id, event, app_id) VALUES ('13081615', now(), '94', 8a0bb010-bb38-4667-8c37-471efef24993);
-- insert into events(bucket, id, event, app_id) VALUES ('13081616', now(), '95', 8a0bb010-bb38-4667-8c37-471efef24993);
-- insert into events(bucket, id, event, app_id) VALUES ('13081616', now(), '96', 8a0bb010-bb38-4667-8c37-471efef24993);
-- insert into events(bucket, id, event, app_id) VALUES ('13081616', now(), '97', 8a0bb010-bb38-4667-8c37-471efef24993);
-- insert into events(bucket, id, event, app_id) VALUES ('13081616', now(), '98', c389039d-1480-499b-86f6-808d3f17ef27);

-- SELECT * FROM events WHERE bucket = '13081616' ORDER BY id DESC LIMIT 2 ;