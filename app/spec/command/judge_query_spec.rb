# encoding: utf-8
require_relative "../../commands/command.rb"

RSpec.describe "クエリの正誤判定" do
  context "正しい解答の場合" do
    it "ACが返ってくる" do
      # TODO: 実装する
      Command.judge_query("problem_001", "./solutions/problem_001.sql")
    end
  end

  context "間違っている回答の場合" do
    it "WAが返ってくる" do
      # TODO: 実装する
    end
  end
end
