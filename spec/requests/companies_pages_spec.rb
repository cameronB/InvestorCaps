require 'spec_helper'

describe "Company pages" do

  subject { page }

  describe "profile page" do

    let(:company) { FactoryGirl.create(:company) }
    before { visit company_path(company) }

    it { should have_selector('h1',    text: company.name) }
    it { should have_selector('title', text: company.symbol) }

    describe "follow/unfollow buttons" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      describe "following a company" do
        before { visit company_path(company) }

        it "should increment the companies followed by count" do
          expect do
            click_button "Follow"
          end.to change(user.company_followed_companies, :count).by(1)
        end

        it "should increment the users following company count" do
          expect do
            click_button "Follow"
          end.to change(company.company_followers, :count).by(1)
        end

        describe "toggling the follow/unfollow button" do
          before { click_button "Follow" }
          it { should have_selector('input', value: 'Unfollow') }
        end
      end

      describe "unfollowing a company" do
        before do
          user.company_follow!(company)
          visit company_path(company)
        end

      it "should decrement the compannies followed by count" do
        expect do
          click_button "Unfollow"
         end.to change(user.company_followed_companies, :count).by(-1)
      end

      it "should decrement the user's following company count" do
          expect do
            click_button "Unfollow"
        end.to change(company.company_followers, :count).by(-1)
      end

      describe "toggling the follow/unfollow button" do
          before { click_button "Unfollow" }
          it { should have_selector('input', value: 'Follow') }
        end
      end
    end
  end

  describe "Check Company followed by a user" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_company) { FactoryGirl.create(:company) }
    before { user.company_follow!(other_company) }

    describe "Companies followers" do
      before do
        sign_in user
        visit company_followers_company_path(other_company)
      end

      it { should have_selector('title', text: full_title('Followers')) }
      it { should have_selector('h3', text: 'Followers') }
      it { should have_link(user.username, href: user_path(user)) }

    end
  end

  describe "Companies Page" do

    describe "index" do
      before do
        sign_in FactoryGirl.create(:user)
        FactoryGirl.create(:user, username: "Bob", email: "bob@example.com")
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

        describe "as an admin user" do
          let(:admin) { FactoryGirl.create(:admin) }
          before do
            sign_in admin
            visit companies_path
          end

          it { should have_link('delete', href: company_path(Company.first)) }
          it "should be able to delete another user" do
            expect { click_link('delete') }.to change(Company, :count).by(-1)
          end
          it { should_not have_link('delete', href: company_path(admin)) }
        end
      end
    end
  end
end
