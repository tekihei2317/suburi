# encoding: utf-8
require "mysql2"

def get_table_names(client, database)
  client.query("use #{database};")
  result = client.query("show tables;")
  table_names = result.map { |row_hash| row_hash.values.first }

  table_names
end

RSpec.describe "解答テーブルの作成" do
  before do
    @client = Mysql2::Client.new(host: "db", password: "password")
    load File.join(File.dirname(__FILE__), "../../scripts/initialize_tables.rb")
  end

  it "解答用のテーブルが作成されること" do
    tables = get_table_names(@client, "problem_1")
    expect(tables).not_to include("001_answers")

    load File.join(File.dirname(__FILE__), "../../scripts/create_answer_tables.rb")

    tables = get_table_names(@client, "problem_1")
    expect(tables).to include("01_answers")
  end
end
