require "mysql2"

class DbClient
  def initialize(settings)
    @client = Mysql2::Client.new(host: settings[:host], password: settings[:password])
  end

  def execute(query)
    @client.query(query)
  end

  def execute_sql_file(file_path)
    queries = File.read(file_path).split(";").map(&:strip)
    queries.each do |query|
      @client.query(query)
    end
  end

  def rename_table(db_name, name_from, name_to)
    @client.query("use #{db_name}")

    # DDLはprepared statementが使えないみたいだけど、ユーザーからの入力じゃないのでこれで大丈夫
    query = "alter table #{name_from} rename to #{name_to};"
    @client.query(query)
  end
end
