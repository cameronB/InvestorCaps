require 'spec_helper'

describe "Company pages" do

  subject { page }

  describe "profile page" do

    let(:company) { FactoryGirl.create(:company) }
    before { visit company_path(company) }

    it { should have_selector('h1',    text: company.name) }
    it { should have_selector('title', text: company.symbol) }
  end

  describe "Companies Page" do

    describe "index" do
      before do
        sign_in FactoryGirl.create(:user)
        FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
        visit companies_path
      end

      it { should have_selector('title', text: 'Companies') }
      it { should have_selector('h1', text: 'Companies') }

      describe "pagination" do

        before(:all) { 1.times { FactoryGirl.create(:company) } }
        after(:all)  { Company.delete_all }

        it "should list each company" do
          Company.paginate(page: 1).each do |company|
            page.should have_selector('li', text: company.name)
          end
        end
      end
    end
  end
end
