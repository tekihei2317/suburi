require "mysql2"
require_relative "utils/db_client.rb"
require_relative "utils/problem.rb"

def create_answers_table(db_name, prefix, solution)
  # solutionは1つのSELECT文(select か with select)
  client = Mysql2::Client.new(host: "db", password: "password")
  client.query("use #{db_name}")

  delete_query = "drop table if exists #{prefix}_answers"
  create_query = "create table #{prefix}_answers #{solution}"

  client.query(delete_query)
  client.query(create_query)
end

db_client = DbClient.new(host: "db", password: "password")
db_names = Dir.glob("./master_data/*/").map { |dir_path| File.basename(dir_path) }

db_names.each do |db_name|
  problem = Problem.new(db_name)

  problem.test_prefixes.each do |prefix|
    # クエリを実行するため、テーブル名を変更する
    problem.tables.each do |table_name|
      db_client.rename_table(db_name, "#{prefix}_#{table_name}", table_name)
    end

    create_answers_table(db_name, prefix, problem.solution)

    # テーブル名をもとに戻す
    problem.tables.each do |table_name|
      db_client.rename_table(db_name, table_name, "#{prefix}_#{table_name}")
    end
  end
end
