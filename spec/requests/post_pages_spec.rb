require 'spec_helper'

describe "Post pages" do

  subject { page }

  before do
    FactoryGirl.create(:company, symbol: "RIO", name: "Rio Tinto")
  end

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "post creation" do
    before { visit root_path }

    describe "with valid information" do

      before { fill_in 'post_symbol', with: "RIO" }
      before { fill_in 'post_title', with: "Annoucment out!" }
      before { fill_in 'post_content', with: "Wow great annoucment out" }
      it "should create a post" do
        expect { click_button "Post" }.to change(Post, :count).by(1)
      end
    end
  end

    describe "with invalid information" do

      it "should not create a post" do
        expect { click_button "Post" }.not_to change(Post, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') } 
      end
    end
end