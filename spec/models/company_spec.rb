# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  symbol     :string(255)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Company do

  before { @company  = Company.new(symbol: "LCY", name: "Legacy Iron Ore") }

  subject { @company }

  it { should respond_to(:symbol) }
  it { should respond_to(:name) }

  it { should be_valid }

  describe "symbol with mixed case" do
    let(:mixed_case_symbol) { "lcy" }

    it "should be saved as all upper-case" do
      @company.symbol = mixed_case_symbol
      @company.save
      @company.reload.symbol.should == mixed_case_symbol.upcase
    end
  end

  describe "when symbol is already taken" do
    before do
      company_with_same_symbol = @company.dup
      company_with_same_symbol.symbol = @company.symbol.upcase
      company_with_same_symbol.save
    end

    it { should_not be_valid }
  end

  describe "when symbol is not present" do
    before { @company.symbol = " " }
    it { should_not be_valid }
  end

  describe "when symbol is too long" do
    before { @company.symbol = "a" * 4 }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @company.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @company.name = "a" * 51 }
    it { should_not be_valid }
  end


end
