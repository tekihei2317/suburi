# encoding: utf-8
require "mysql2"
require_relative "../../commands/command.rb"

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
  context "DBセットアップコマンドを実行した場合" do
    before :context do
      @client = Mysql2::Client.new(host: "db", password: "password")

      @db_names = ["problem_001", "problem_002"]
      @db_names.each do |db_name|
        @client.query("drop database if exists #{db_name}")
      end

      Command.initialize_databases
    end

    it "問題1のデータベースとテーブルが作られること" do
      databases = get_database_names(@client)
      expect(databases).to include(@db_names.first)

      tables = get_table_names(@client, @db_names.first)
      expect(tables).to include("01_pairs")
    end

    it "問題2のデータベースとテーブルが作られること" do
      databases = get_database_names(@client)
      expect(databases).to include(@db_names[1])

      tables = get_table_names(@client, @db_names[1])
      expect(tables).to include("01_numbers_1")
    end
  end
end
