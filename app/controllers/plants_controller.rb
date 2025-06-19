class PlantsController < ApplicationController
  def show
    @user = User.first # Temporaire, on simulera un vrai login plus tard
    @plant = @user.plant
    @log = @plant.daily_log
    @quest = @log.quest || @plant.assign_daily_quest!
    @unlocked_achievements = @user.achievements
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

  def submit_quest_response
    @user = User.first
    @plant = @user.plant
    response = params[:quest_response]

    result = @plant.submit_quest_response!(response)

    flash[:notice] =
      case result
      when :quest_completed then "Ta réponse a été enregistrée 🌟"
      when :already_done then "Tu as déjà fait la quête aujourd'hui !"
      when :no_quest then "Aucune quête assignée."
      when :invalid_type then "Cette quête ne demande pas de réponse écrite."
      else "Erreur inconnue"
      end

    redirect_to plant_path
  end
end
