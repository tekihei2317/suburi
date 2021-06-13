# encoding: utf-8
require "mysql2"

def get_database_names(client)
  result = client.query("show databases;")
  database_names = result.to_a.map { |row_hash| row_hash.values.first }

  database_names
end

def get_table_names(client, database)
  client.query("use #{database};")
  result = client.query("show tables;")
  table_names = result.map { |row_hash| row_hash.values.first }

  table_names
end

RSpec.describe "問題データベースのセットアップ" do
  before do
    @client = Mysql2::Client.new(host: "db", password: "password")
    @client.query("drop database if exists problem_1;")
  end

  it "データベースとテーブルが作られること" do
    databases = get_database_names(@client)
    expect(databases).not_to include("problem_1")

    load File.join(File.dirname(__FILE__), "../../scripts/initialize_tables.rb")

    databases = get_database_names(@client)
    expect(databases).to include("problem_1")

    tables = get_table_names(@client, "problem_1")
    expect(tables).to include("01_pairs")
  end
end
