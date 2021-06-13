require_relative "utils/db_client.rb"

def create_db_from_directory(db_client, directory)
  db_name = File.basename(directory)
  db_client.execute("drop database if exists #{db_name}")
  db_client.execute("create database #{db_name}")
end

def execute_sql_files(db_client, directory)
  database_name = File.basename(directory)
  db_client.execute("use #{database_name}")

  files = Dir.glob(File.join(directory, "*.sql"))
  # initialize.sqlを最初に実行するようにソート
  files.sort_by! { |file| File.basename(file) == "initialize.sql" ? 0 : 1 }

  files.each do |file_path|
    db_client.execute_sql_file(file_path)
  end
end

db_client = DbClient.new(host: "db", password: "password")

# TODO: 実行している場所からの相対パスになっているので修正したほうが良い?
Dir.glob("./master_data/*/").each do |directory|
  # ディレクトリ名からデータベースを作成する
  create_db_from_directory(db_client, directory)

  # 配下のSQLファイルを実行する
  execute_sql_files(db_client, directory)
end
