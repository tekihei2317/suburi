require "mysql2"
require_relative "utils/db_client.rb"

def create_answers_table(prefix, solution)
  # solutionは1つのSELECT文(select か with select)
  client = Mysql2::Client.new(host: "db", password: "password")
  client.query("use problem_1")

  delete_query = "drop table if exists #{prefix}_answers"
  create_query = "create table #{prefix}_answers #{solution}"

  client.query(delete_query)
  puts create_query
  client.query(create_query)
end

db_client = DbClient.new(host: "db", password: "password")

# TODO: 値をファイル名かDB名から取得する
prefixes = ["01", "02", "03"]
tables = ["pairs"]

# TODO: 値をファイルから取得する
solution = "select a + b as sum from pairs;"

prefixes.each do |prefix|
  # クエリを実行するため、テーブル名を変更する
  tables.each do |table_name|
    db_client.rename_table("#{prefix}_#{table_name}", table_name)
  end

  db_client.create_answers_table(prefix, solution)

  # テーブル名をもとに戻す
  tables.each do |table_name|
    db_client.rename_table(table_name, "#{prefix}_#{table_name}")
  end
end
