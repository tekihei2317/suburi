client = Mysql2::Client.new(host: "db", password: "password")
query = "select a + b from 01_pairs;"
