# encoding: utf-8
class Problem
  attr_accessor :test_prefixes, :tables, :solution

  def initialize(db_name)
    @db_name = db_name

    # テストケースのプレフィックスの配列
    @test_prefixes = collect_test_prefixes

    # 問題で使われるテーブル名の配列
    @tables = collect_tables

    # 問題の回答
    @solution = read_solution
  end

  private

  # TODO: ディレクトリ構造を知っているので、別のクラスに分離したい
  def read_solution
    file_path = "solutions/#{@db_name}.sql"
    first_query = File.read(file_path).split(";").first
  end

  def collect_sql_files
    files = Dir.glob(File.join("./master_data", @db_name, "*.sql"))
    ignore_file = "initialize.sql"
    files
      .map { |file_path| File.basename(file_path) }
      .filter { |file| file != ignore_file }
  end

  def collect_test_prefixes
    regex = /([0-9a-zA-Z]+)_([0-9a-zA-Z_]+).sql/
    collect_sql_files.map { |file| file[regex, 1] }.uniq
  end

  def collect_tables
    regex = /([0-9a-zA-Z]+)_([0-9a-zA-Z_]+).sql/
    collect_sql_files.map { |file| file[regex, 2] }.uniq
  end
end
