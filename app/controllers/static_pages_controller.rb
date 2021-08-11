class StaticPagesController < ApplicationController
  def help
  end

  def home
  end

  def error404
    render status: 404
  end

  def error500
    render status: 500
  end
end
