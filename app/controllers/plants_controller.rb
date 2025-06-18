class PlantsController < ApplicationController
  def show
    @user = User.first # Temporaire, on simulera un vrai login plus tard
    @plant = @user.plant
    @log = @plant.daily_log
    @quest = @log.quest || @plant.assign_daily_quest!
  end

  def water
    @user = User.first
    @plant = @user.plant
    result = @plant.water_today!
    redirect_to plant_path, notice: (result == :already_watered ? "Déjà arrosée !" : "Plante arrosée 💧")
  end

  def do_quest
    @user = User.first
    @plant = @user.plant
    result = @plant.do_quest_today!
    redirect_to plant_path, notice: (result == :already_done ? "Tu as déjà fait la quête !" : "Quête complétée 🌟")
  end
end
