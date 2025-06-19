class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @plant = @user.plant
    @achievement_count = @user.achievements.count
  end
end
