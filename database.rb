require 'sqlite3'

# Database connection setup
DB = SQLite3::Database.new('reelwords.db')

# Create tables if they don't exist
DB.execute <<-SQL
  CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    uuid BLOB,
    username TEXT,
    password TEXT,
    email TEXT,
    create_datetime INTEGER,
    modified_datetime INTEGER
  );
SQL

DB.execute <<-SQL
  CREATE TABLE IF NOT EXISTS settings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    uuid BLOB,
    setting_name TEXT,
    setting_value TEXT,
    create_datetime INTEGER,
    modified_datetime INTEGER
  );
SQL

DB.execute <<-SQL
  CREATE TABLE IF NOT EXISTS user_stats (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_uuid BLOB,
    stat_name TEXT,
    stat_value TEXT,
    create_datetime INTEGER,
    modified_datetime INTEGER
  );
SQL

