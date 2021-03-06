require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1', text: 'Sign in') }
    it { should have_selector('title', text: 'Sign in') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('title', text: 'Sign in') }
      it { should have_selector('div.alert.alert-alert', text: 'You need to sign in or sign up before continuing.') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it { should have_selector('title', text: 'Home')}
      it { should have_link('Shareholders', href: users_path) }
      it { should have_link('My Posts', href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_registration_path) }
      it { should have_link('Sign out', href: destroy_user_session_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the posts controller" do

        describe "submitting to the create action" do
          before { post posts_path }
          specify { response.should redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete post_path(FactoryGirl.create(:post)) }
          specify { response.should redirect_to(signin_path) }
        end
      end

      describe "In the company s_relationships controller" do
        describe "submitting to the create action do" do
          before { post c_relationships_path }
          specify { response.should redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete c_relationship_path(1) }
          specify { response.should redirect_to(signin_path) }
        end
      end

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_registration_path
          fill_in "user_email", with: user.email
          fill_in "user_password", with: user.password
          click_button "Sign in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            page.should have_selector('title', text: 'Edit')
          end

          describe "when signing in again" do
            before do
              click_link "Sign out"
              visit signin_path
              fill_in "user_email", with: user.email
              fill_in "user_password", with: user.password
              click_button "Sign in"
            end

            it "should render the default home page" do
              page.should have_selector('title', test: 'Home')
            end
          end
        end
      end

      describe "in the Companies Controller" do

        describe "visiting the index" do
          before { visit companies_path }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "as non-admin user" do
          let(:company) { FactoryGirl.create(:company) }
          let(:non_admin) { FactoryGirl.create(:user) }

          before { sign_in non_admin }

          describe "submitting a DELETE request to the Companies#destroy action" do
            before { delete company_path(company) }
            specify { response.should redirect_to(signin_path) }
          end
        end
      end

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_registration_path }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "visiting user index" do
          before { visit users_path }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "visiting the users followed companies page" do
          before { visit s_following_user_path(user) }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "visiting the following page" do
          before { visit s_following_user_path(user) }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "visiting the followers page" do
          before { visit s_followers_user_path(user) }
          it { should have_selector('title', text: 'Sign in') }
        end
      end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user }

      describe "visiting Users#edit page" do
        before { visit edit_user_registration_path(wrong_user) }
        it { should have_selector('title', text: full_title('')) }
      end
    end
  end


    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin }

    end
  end
end