require "mysql2"

def execute_sql_file(file_path)
  client = Mysql2::Client.new(host: "db", password: "password")

  queries = File.read(file_path).split(";")
  queries.each do |query|
    puts query
    client.query(query)
  end
end

execute_sql_file("./master_data/initialize.sql")

Dir.glob("./master_data/tables/*.sql").each do |file_path|
  puts file_path
  execute_sql_file(file_path)
end
