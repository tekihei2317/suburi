# encoding: utf-8
require_relative "../scripts/utils/db_client.rb"
require_relative "../scripts/utils/problem.rb"
require_relative "./modules/initialize_databases.rb"
require_relative "./modules/create_answers.rb"

class Command
  extend Init, CreateAnswers
end
