-- Show all column families
SELECT keyspace, columnfamily_name, comment
  FROM system.schema_columnfamilies;

-- Show all keyspaces
describe keyspaces;

-- Show all tables in a kyspace
use <KEYSPACE>;
describe tables;

-- Select 5 data from events table
select * from application.events LIMIT 5;

-- select COUNT(*) 
--   FROM events 
--   WHERE app_id = c389039d-1480-499b-86f6-808d3f17ef27  
--   and created_at >= maxTimeuuid('2014-02-27 01:07:20+0300') ;

-- Get last 5 events
select id, bucket, app_id  from events WHERE bucket = '2014-02-28-01' ORDER BY id DESC  LIMIT 5;

-- Count number of events in bucket
select COUNT(*) FROM events WHERE bucket = '2014-02-28-01';

-- UTC time query where it equals time
select COUNT(*) FROM events WHERE bucket = '2014-02-28-02' AND id >= maxTimeuuid('2014-02-28 02:00:00+0000') 

-- Time slice of 5 minutes in time
select COUNT(*) FROM events 
  WHERE bucket = '2014-02-28-02' 
    AND id >= minTimeuuid('2014-02-28 02:00:00+0000') 
    AND id <  maxTimeuuid('2014-02-28 02:05:00+0000');