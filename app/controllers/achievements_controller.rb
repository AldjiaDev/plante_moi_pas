class AchievementsController < ApplicationController
  before_action :authenticate_user!

  def index
    @unlocked_achievements = current_user.achievements
  end
end
