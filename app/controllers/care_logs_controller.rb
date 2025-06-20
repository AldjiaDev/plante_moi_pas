class CareLogsController < ApplicationController
  def index
    if current_user.plant.present?
      @care_logs = current_user.plant.plant_logs.order(date: :desc)
    else
      @care_logs = []
      flash[:alert] = "Vous n'avez pas encore de plante."
    end
  end
end

