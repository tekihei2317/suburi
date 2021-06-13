require "mysql2"
require_relative "utils/db_client.rb"

db_client = DbClient.new(host: "db", password: "password")
db_client.execute_sql_file("./master_data/initialize.sql")

Dir.glob("./master_data/tables/*.sql").each do |file_path|
  db_client.execute_sql_file(file_path)
end
