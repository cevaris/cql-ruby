-- Show all column families
SELECT keyspace, columnfamily_name, comment
  FROM system.schema_columnfamilies;

-- Show all keyspaces
describe keyspaces;

-- Show all tables in a kyspace
use <KEYSPACE>;
describe tables;
