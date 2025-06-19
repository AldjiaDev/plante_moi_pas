class PlantsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @plant = @user.plant
    @plant.update_mood_if_new_day!

    unless @plant
      redirect_to new_plant_path and return
    end

    @log = @plant.daily_log
    @quest = @log.quest || @plant.assign_daily_quest!
    @unlocked_achievements = @user.achievements
  end

  def new
    @plant = current_user.build_plant
  end

  def create
    @plant = current_user.build_plant(plant_params)
    @plant.last_watered_at = Time.current
    @plant.state = "active"
    @plant.mood = "joyeuse"
    @plant.consecutive_days_watered = 1
    @plant.growth_stage = "sprout"

    if @plant.save
      redirect_to plant_path, notice: "Ta plante est née !"
    else
      render :new, status: :unprocessable_entity
    end
  end


  def water
    @user = current_user
    @plant = @user.plant
    result = @plant.water_today!
    redirect_to plant_path, notice: (result == :already_watered ? "Déjà arrosée !" : "Plante arrosée 💧")
  end

  def do_quest
    @user = current_user
    @plant = @user.plant
    result = @plant.do_quest_today!
    redirect_to plant_path, notice: (result == :already_done ? "Tu as déjà fait la quête !" : "Quête complétée 🌟")
  end

  def submit_quest_response
    @user = current_user
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


  private

  def plant_params
    params.require(:plant).permit(:name, :personality)
  end
end
