class StaticPagesController < ApplicationController
 
  def home
  	  if signed_in?
      	@post  = current_user.posts.build
        sql = ["SELECT posts.*
                  FROM posts
                  INNER JOIN companies on posts.symbol = companies.symbol
                  WHERE (user_id IN (SELECT s_followed_id FROM s_relationships WHERE s_follower_id = ?))
                  OR (companies.id IN (SELECT c_followed_id from c_relationships WHERE c_follower_id = ?))
                  OR user_id = ? ORDER BY posts.created_at DESC", current_user.id, current_user.id, current_user.id]

      	@feed_items = current_user.posts.paginate_by_sql(sql, :page => @page)
    end
  end

  def about

  end

  def contact

  end

end
