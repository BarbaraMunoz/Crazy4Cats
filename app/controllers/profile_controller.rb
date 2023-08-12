class ProfileController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @posts = @user.posts.order(created_at: :desc)
  end
end


