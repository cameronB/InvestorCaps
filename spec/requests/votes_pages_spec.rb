require 'spec_helper'

describe "Votes Pages" do
	
	subject { page }

	before do
   		FactoryGirl.create(:company, symbol: "HAW", name: "Hawthorn Resources")
  	end

	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user }

	describe "Post creation" do
		before { visit root_path }

    	describe "with valid information" do

      	before { fill_in 'post_symbol', with: "HAW" }
      	before { fill_in 'post_title', with: "Annoucement out" }
      	before { fill_in 'post_content', with: "Wow great annoucement out" }
      		it "should create a post" do
        		expect { click_button "Post" }.to change(Post, :count).by(1)
      		end
    	end
    end

    describe "Voting up a post" do
    	let!(:post) { FactoryGirl.create(:post, user: user, symbol: "HAW", title: "Annoucement out", content: "Wow great annoucement out") }

    	describe "navigate to root" do
      		before do
        	visit root_path
    	end

     		it { should have_content(post.title) }

     		it "should have a 0 count by default for the post votes" do
     		    page.should have_selector('div', text: "0")
     		end
   		end
   	end


   	describe "Voting up a comment" do
   		let!(:post) { FactoryGirl.create(:post, user: user, symbol: "HAW", title: "Annoucement out", content: "Wow great annoucement out") }

   		describe "navigate to root" do
      		before do
        	visit comment_path(post.id)
    	end

     	it "should be on comment page" do
     	  	page.should have_selector('h3', text: "Post")
     	end

     	it "create a comment and has default count of votes" do
  			fill_in 'comment_message', with: "wow great" 
  			expect { click_button "Post Comment" }.to change(Comment, :count).by(1)
  			should have_content("wow great")
  			page.should have_selector('div', text: "0")
  		end

  	end
  end
end