require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do

    before do
     sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, username: "Bob", email: "bob@example.com")
      FactoryGirl.create(:user, username: "Ben", email: "ben@example.com")
      visit users_path
    end

    it { should have_selector('title', text: 'Users') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }

      let(:first_page) { User.paginate(page: 1) }
      let(:second_page) { User.paginate(page: 2) }

      it { should have_link('Next') }
      its(:html) { should match('>2</a>') }

      it "should list each user" do
        User.all[0..2].each do |user|
          page.should have_selector('li', text: user.username)
        end
      end

      it "should list the first page of users" do
        first_page.each do |user|
          page.should have_selector('li', text: user.username)
        end
      end

      it "should not list the second page of users" do
        second_page.each do |user|
          page.should_not have_selector('li', text: user.username)
        end
      end

      describe "showing the second page" do
        before { visit users_path(page: 2) }

        it "should list the second page of users" do
          second_page.each do |user|
            page.should have_selector('li', text: user.username)
          end
        end
      end
    end

    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          click_link "Sign out"
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('delete') }.to change(User, :count).by(-1)
        end
      end
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:post1) { FactoryGirl.create(:post, user: user, symbol: "LCY", title: "Great new announcement", content: "Buyout yay!") }
    let!(:post2) { FactoryGirl.create(:post, user: user, symbol: "HAW", title: "Bad new announcement", content: "OMG no a buyout") }

    before { sign_in user }

    before { visit user_path(user) }

    describe "posts" do
      it { should have_content(post1.title) }
      it { should have_content(post2.title) }
    end

     it "should have the correct title" do
        click_link "Great new announcement"
        page.should have_selector 'title', text: full_title('Great new announcement')
    end
    
    describe "follow/unfollow buttons" do
      let(:other_user) { FactoryGirl.create(:user) }

      before do
        click_link "Sign out"
        visit signin_path
        fill_in "user_email", with: user.email
        fill_in "user_password", with: user.password
        click_button "Sign in"
      end

      describe "following a user" do
        before { visit user_path(other_user) }

        it "should increment the followed user count" do
          expect do
            click_button "Follow"
          end.to change(user.s_followed_users, :count).by(1)
        end

        it "should increment the other user's followers count" do
          expect do
            click_button "Follow"
          end.to change(other_user.s_followers, :count).by(1)
        end

        describe "toggling the button" do
          before { click_button "Follow" }
          it { should have_selector('input', value: 'Unfollow') }
        end
      end

      describe "unfollowing a user" do
        before do
          user.s_follow!(other_user)
          visit user_path(other_user)
        end

        it "should decrement the followed user count" do
          expect do
            click_button "Unfollow"
          end.to change(user.s_followed_users, :count).by(-1)
        end

        it "should decrement the other user's followers count" do
          expect do
            click_button "Unfollow"
          end.to change(other_user.s_followers, :count).by(-1)
        end

        describe "toggling the button" do
          before { click_button "Unfollow" }
          it { should have_selector('input', value: 'Follow') }
        end
      end
    end
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1', text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Sign up" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "user_username", with: "Example"
        fill_in "user_email", with: "user@example.com"
        fill_in "user_password", with: "foobar1234"
        fill_in "user_password_confirmation", with: "foobar1234"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }

        let(:user) { User.find_by_email('user@example.com') }

        it { should have_selector('div.alert.alert-notice', text: 'Welcome! You have signed up successfully.') }
        it { should have_link('Sign out') }
      end
    end
  end

  describe "Check Users followed Companies" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_company) { FactoryGirl.create(:company) }
    before { user.c_follow!(other_company) }

    describe "Companies followed" do
      before do
        sign_in user
        visit c_following_user_path(user)
      end

      it { should have_selector('title', text: full_title('Following')) }
      it { should have_selector('h3', text: 'Following') }
      it { should have_link(other_company.name, href: company_path(other_company)) }
    end
  end


  describe "following/followers" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    before { user.s_follow!(other_user) }

    describe "followed users" do
      before do
        sign_in user
        visit s_following_user_path(user)
      end

      it { should have_selector('title', text: full_title('Following')) }
      it { should have_selector('h3', text: 'Following') }
      it { should have_link(other_user.username, href: user_path(other_user)) }
    end

    describe "followers" do
      before do
        sign_in other_user
        visit s_followers_user_path(other_user)
      end

      it { should have_selector('title', text: full_title('Followers')) }
      it { should have_selector('h3', text: 'Followers') }
      it { should have_link(user.username, href: user_path(user)) }
    end
  end
end