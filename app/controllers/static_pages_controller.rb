class StaticPagesController < ApplicationController
 
  def home
  	  if signed_in?
      	@post  = current_user.posts.build
        sql = ["SELECT *
                FROM users
                INNER JOIN company_relationships ON users.id=company_relationships.cfollower_id
                INNER JOIN companies ON company_relationships.cfollowed_id=companies.id
                INNER JOIN posts ON companies.symbol = posts.symbol
                WHERE (users.id IN (SELECT cfollower_id from company_relationships
                WHERE cfollower_id = ?) OR users.id = ?)
                OR (user_id IN (SELECT followed_id FROM relationships
                WHERE follower_id = ?) OR user_id = ?)
                GROUP BY posts.id
                ORDER BY posts.created_at DESC", current_user.id, current_user.id, current_user.id, current_user.id]
      	@feed_items = current_user.posts.paginate_by_sql(sql, :page => @page)
    end
  end

  def about
  end

  def contact
  end
end
