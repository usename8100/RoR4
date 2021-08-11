class StaticPagesController < ApplicationController
  def help
  end

  def home
  end

  def not_found
    render status: 404
  end

  def internal_server_error
    render status: 500
  end
end
