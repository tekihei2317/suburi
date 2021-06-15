# encoding: utf-8
require_relative "../utils/db_client.rb"
require_relative "../utils/problem.rb"
require_relative "./modules/initialize_databases.rb"
require_relative "./modules/create_answers.rb"
require_relative "./modules/judge_query.rb"

class Command
  extend Init, CreateAnswers, JudgeQuery
end
