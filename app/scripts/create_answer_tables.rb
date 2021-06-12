require "mysql2"

def rename_table(name_from, name_to)
  # TODO: clientの初期化処理が重複しているのでまとめる
  client = Mysql2::Client.new(host: "db", password: "password")
  client.query("use problem_1")

  # DDLはprepared statementが使えないみたいだけど、ユーザーからの入力じゃないのでこれで大丈夫
  query = "alter table #{name_from} rename to #{name_to};"
  client.query(query)
end

def create_answers_table(prefix, solution)
  # solutionは1つのSELECT文(select か with select)
  client = Mysql2::Client.new(host: "db", password: "password")
  client.query("use problem_1")

  delete_query = "drop table if exists #{prefix}_answers"
  create_query = "create table #{prefix}_answers #{solution}"

  client.query(delete_query)
  client.query(create_query)
end

# TODO: 値をファイル名かDB名から取得する
prefixes = ["01", "02", "03"]
tables = ["pairs"]

# TODO: 値をファイルから取得する
solution = "select a + b as sum from pairs;"

prefixes.each do |prefix|
  # クエリを実行するため、テーブル名を変更する
  tables.each do |table_name|
    rename_table("#{prefix}_#{table_name}", table_name)
  end

  create_answers_table(prefix, solution)

  # テーブル名をもとに戻す
  tables.each do |table_name|
    rename_table(table_name, "#{prefix}_#{table_name}")
  end
end
