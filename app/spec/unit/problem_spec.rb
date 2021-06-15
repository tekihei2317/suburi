# encoding: utf-8
require_relative "../../scripts/utils/problem.rb"

RSpec.describe "Problemクラス" do
  context "問題1の場合" do
    before do
      @problem = Problem.new("problem_001")
    end

    it "テストケースのプレフィックスを保持していること" do
      expect(@problem.test_prefixes).to include ("01")
      expect(@problem.test_prefixes).to include ("02")
    end

    it "テーブル名を保持していること" do
      expect(@problem.tables).to include("pairs")
    end
  end
end
