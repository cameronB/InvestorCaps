require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_selector('title', text: full_title('')) }
    it { should have_selector('title', text: ' | Home')}

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
      FactoryGirl.create(:post, user: user, symbol: "LCY", title: "Great new annoucment", content: "Buyout yay!") 
      FactoryGirl.create(:post, user: user, symbol: "HAW", title: "Bad new annoucment", content: "OMG no a buyout")
        sign_in user
        visit root_path
      end


      it { should have_selector('h3', text: 'Post Feed') }

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.title)
        end
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
  end
end