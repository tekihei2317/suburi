# encoding: utf-8
require_relative "../scripts/utils/db_client.rb"
require_relative "../scripts/utils/problem.rb"

module Command
  def self.initialize_databases
    db_client = DbClient.new(host: "db", password: "password")

    # TODO: 実行している場所からの相対パスになっているので修正したほうが良さそう
    Dir.glob("./master_data/*/").each do |directory|
      # ディレクトリ名からデータベースを作成する
      create_db_by_dirname(db_client, directory)

      # 配下のSQLファイルを実行する
      execute_containing_files(db_client, directory)
    end
  end

  def self.create_answer_tables
    db_client = DbClient.new(host: "db", password: "password")
    db_names = Dir.glob("./master_data/*/").map { |dir_path| File.basename(dir_path) }

    # TODO: ネストが深いので分割する
    db_names.each do |db_name|
      problem = Problem.new(db_name)

      problem.test_prefixes.each do |test_prefix|
        # クエリを実行するため、テーブル名を変更する
        problem.tables.each do |table_name|
          db_client.rename_table(db_name, "#{test_prefix}_#{table_name}", table_name)
        end

        begin
          create_answer_table(db_client, test_prefix, problem.solution)
        rescue => e
          puts e.message
        ensure
          # テーブル名をもとに戻す
          problem.tables.each do |table_name|
            db_client.rename_table(db_name, table_name, "#{test_prefix}_#{table_name}")
          end
        end
      end
    end
  end

  # ヘルパーメソッドたち
  # TODO: 単体で呼ぶことは想定していないので別の場所に書いたほうが良さそう
  def self.create_db_by_dirname(db_client, directory)
    db_name = File.basename(directory)
    db_client.execute("drop database if exists #{db_name}")
    db_client.execute("create database #{db_name}")
  end

  def self.execute_containing_files(db_client, directory)
    database_name = File.basename(directory)
    db_client.execute("use #{database_name}")

    files = Dir.glob(File.join(directory, "*.sql"))
    # initialize.sqlを最初に実行するようにソート
    files.sort_by! { |file| File.basename(file) == "initialize.sql" ? 0 : 1 }

    files.each do |file_path|
      db_client.execute_sql_file(file_path)
    end
  end

  def self.create_answer_table(db_client, test_prefix, solution)
    table_name = "#{test_prefix}_answers"
    db_client.execute("drop table if exists #{table_name}")
    db_client.execute("create table #{table_name} #{solution}")
  end
end
