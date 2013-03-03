require 'spec_helper'

describe "Comment Pages" do
	
	subject { page }
  
    before do
   		FactoryGirl.create(:company, symbol: "RIO", name: "Rio Tinto")
  	end

	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user }

	describe "Post creation" do
	    before { visit root_path }

    	describe "with valid information" do

      	before { fill_in 'post_symbol', with: "RIO" }
      	before { fill_in 'post_title', with: "Annoucement out" }
      	before { fill_in 'post_content', with: "Wow great annoucement out" }
      		it "should create a post" do
        		expect { click_button "Post" }.to change(Post, :count).by(1)
      		end
    	end
    end

  	describe "posting a comment" do
    	let!(:post) { FactoryGirl.create(:post, user: user, symbol: "RIO", title: "Annoucement out", content: "Wow great annoucement out") }

    	before { visit user_path(user) }
    	before { click_link "Annoucement out" }

    	describe "posts" do
      		it { should have_content(post.title) }
    	end

  		it "with valid message should create a comment" do
  			fill_in 'comment_message', with: "Awesome Annoucement" 
  			expect { click_button "Post Comment" }.to change(Comment, :count).by(1)
  			should have_content("Awesome Annoucement")
  		end

  	end

    describe "with invalid information" do
      let!(:post) { FactoryGirl.create(:post, user: user, symbol: "RIO", title: "Announcement out", content: "Wow great announcement out") }

      before { visit user_path(user) }
      before { click_link "Announcement out" }

      it "should not create a post" do
        expect { click_button "Post Comment" }.not_to change(Comment, :count)
      end
    end
end