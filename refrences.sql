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

select id, app_id, created_at from application.events WHERE created_at < '2014-02-26 13:15:20-0700' LIMIT 5;