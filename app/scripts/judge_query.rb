require "mysql2"
require_relative "utils/db_client.rb"
require_relative "utils/problem.rb"

def first_query(file_path)
  File.read(file_path).split(";").first
end

def judge_solution(db_client, prefix, solution_path)
  answer = db_client.execute("select * from #{prefix}_answers")
  judge_result = db_client.execute(first_query(solution_path))

  puts "result: #{answer.to_a.join(" ")}"
  puts "expected: #{judge_result.to_a.join(" ")}"

  # 配列の比較なので順番も考慮される(TODO: 順番は考慮しないようにする)
  return answer.to_a == judge_result.to_a
end

# TODO: 引数が足りない場合を考慮する
problem_name, solution_path = ARGV
problem = Problem.new(problem_name)

db_client = DbClient.new(host: "db", password: "password")
db_name = problem_name
db_client.execute("use #{db_name}")

problem.test_prefixes.each do |prefix|
  # クエリを実行するため、テーブル名を変更する
  problem.tables.each do |table_name|
    db_client.rename_table(db_name, "#{prefix}_#{table_name}", table_name)
  end

  begin
    is_correct = judge_solution(db_client, prefix, solution_path)
    puts is_correct ? "AC" : "WA"
  rescue => e
    puts e.message
  ensure
    # テーブル名をもとに戻す
    problem.tables.each do |table_name|
      db_client.rename_table(db_name, table_name, "#{prefix}_#{table_name}")
    end
  end
end
