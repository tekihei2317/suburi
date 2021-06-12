require "mysql2"

def rename_table(name_from, name_to)
  client = Mysql2::Client.new(host: "db", password: "password")
  client.query("use problem_1")

  # DDLはprepared statementが使えないみたいだけど、ユーザーからの入力じゃないのでこれで大丈夫
  query = "alter table #{name_from} rename to #{name_to};"
  client.query(query)
end

def judge_solution(prefix, users_solution)
  client = Mysql2::Client.new(host: "db", password: "password")
  client.query("use problem_1")

  answer = client.query("select * from #{prefix}_answers")
  judge_result = client.query(users_solution)

  puts "result: #{answer.to_a.join(" ")}"
  puts "expected: #{judge_result.to_a.join(" ")}"

  # 配列の比較なので順番も考慮される(TODO: 順番は考慮しないようにする)
  return answer.to_a == judge_result.to_a
end

prefixes = ["01", "02", "03"]
tables = ["pairs"]

solution = readlines.map(&:strip).join(" ")

prefixes.each do |prefix|
  # クエリを実行するため、テーブル名を変更する
  tables.each do |table_name|
    rename_table("#{prefix}_#{table_name}", table_name)
  end

  is_correct = judge_solution(prefix, solution)
  puts is_correct ? "AC" : "WA"

  # テーブル名をもとに戻す
  tables.each do |table_name|
    rename_table(table_name, "#{prefix}_#{table_name}")
  end
end
