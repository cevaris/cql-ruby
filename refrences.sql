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

select COUNT(*) 
  FROM events 
  WHERE app_id = c389039d-1480-499b-86f6-808d3f17ef27  
  and created_at >= maxTimeuuid('2014-02-27 01:07:20+0300') ;