class StaticPagesController < ApplicationController
 
  def home
  	  if signed_in?
      	@post  = current_user.posts.build
        sql = ["SELECT 'posts'.* 
                  FROM 'posts'
                  INNER JOIN companies on posts.symbol = companies.symbol
                  WHERE (user_id IN (SELECT followed_id FROM relationships WHERE follower_id = ?)) 
                  OR (companies.id IN (SELECT cfollowed_id from company_relationships WHERE cfollower_id = ?))
                  OR user_id = ? ORDER BY posts.created_at DESC", current_user.id, current_user.id, current_user.id]

      	@feed_items = current_user.posts.paginate_by_sql(sql, :page => @page)
    end
  end

  def about

  end

  def contact

  end

end
