class StaticPagesController < ApplicationController
 
  def home
  	  if signed_in?
      	@post  = current_user.posts.build
      	@feed_items = current_user.posts.paginate_by_sql(["SELECT * 
                                                          FROM posts 
                                                          INNER JOIN companies ON posts.symbol=companies.symbol
                                                          WHERE (companies.id IN (SELECT cfollowed_id FROM company_relationships
                                                          WHERE cfollowed_id = '4') OR companies.id = '4') 
                                                          OR (user_id IN (SELECT followed_id FROM relationships
                                                          WHERE follower_id = 1) OR user_id = 1)
                                                          ORDER BY posts.created_at DESC"], :page => @page)
    end
  end

  def about
  end

  def contact
  end
end
