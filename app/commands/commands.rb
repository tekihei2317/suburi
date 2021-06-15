require_relative "../scripts/utils/db_client.rb"
require_relative "../scripts/utils/problem.rb"

module Command
  def self.create_answer_tables
    db_client = DbClient.new(host: "db", password: "password")
    db_names = Dir.glob("./master_data/*/").map { |dir_path| File.basename(dir_path) }

    # TODO: 分割したい
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

  def self.create_answer_table(db_client, test_prefix, solution)
    table_name = "#{test_prefix}_answers"
    db_client.execute("drop table if exists #{table_name}")
    db_client.execute("create table #{table_name} #{solution}")
  end
end
