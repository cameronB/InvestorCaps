require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_selector('h1', text: 'InvestorCaps') }
    it { should have_selector('title', text: full_title('')) }
    it { should have_selector('title', text: ' | Home')}

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit root_path
      end

      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("Following 0 Shareholders", href: following_user_path(user)) }
        it { should have_link("Followed By 1 Shareholders", href: followers_user_path(user)) }
      end
    end
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_selector('h1', text: 'Help') }
    it { should have_selector('title', text: full_title('Help')) }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_selector('h1', text: 'About') }
    it { should have_selector('title', text: full_title('About Us')) }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_selector('h1', text: 'Contact') }
    it { should have_selector('title', text: full_title('Contact')) }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About Us')
    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact')
    click_link "Home"
    click_link "Shareholder Registration"
    page.should have_selector 'title', text: full_title('Register')
    click_link "InvestorCaps"
    page.should have_selector 'h1', text: 'InvestorCaps'
  end
end