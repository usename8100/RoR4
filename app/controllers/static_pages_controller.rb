class StaticPagesController < ApplicationController
  def help
  end

  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def not_found
    render status: 404
  end

  def internal_server_error
    render status: 500
  end
end
