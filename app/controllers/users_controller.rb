class UsersController < ApplicationController
  def achievements
    @user = current_user
    @unlocked_achievements = @user.achievements
  end
end
