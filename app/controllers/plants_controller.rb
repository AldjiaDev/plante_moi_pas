class PlantsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @plant = @user.plant

    unless @plant
      redirect_to new_plant_path and return
    end

    @plant.update_mood_if_new_day!
    @log = @plant.daily_log
    @quest = @log.quest || @plant.assign_daily_quest!
    @unlocked_achievements = @user.achievements

    @plant_emoji =
      case @plant.growth_stage
      when "sprout" then "🌱"
      when "leafy" then "🌿"
      when "bushy" then "🌴"
      when "tree" then "🌳"
      else "🪴"
      end

    @plant_stage_text =
      case @plant.growth_stage
      when "sprout" then "Je viens de naître... ne m'oublie pas !"
      when "leafy" then "Regarde comme je deviens feuillu 🌿"
      when "bushy" then "Je suis touffue et fière 😎"
      when "tree" then "Je suis devenue un arbre majestueux. Arrose-moi comme une reine 👑"
      else "État inconnu… ai-je été clonée ? 🤖"
      end
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

  def edit
    @plant = current_user.plant
    redirect_to new_plant_path unless @plant
  end

  def update
    @plant = current_user.plant
    if @plant.update(plant_params)
      redirect_to plant_path, notice: "Ta plante a été mise à jour 🌿"
    else
      render :edit, status: :unprocessable_entity
    end
  end



  def water
    @plant = current_user.plant
    @plant.water_today!

    care_log = CareLog.find_or_initialize_by(
      user: current_user,
      plant: @plant,
      date: Date.today
    )

    care_log.watered = true
    care_log.save!

    redirect_to plant_path, notice: "Merci de m’avoir arrosée 💦🌱 Je me sens déjà mieux !"
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

    # Mise à jour ou création du CareLog du jour
    today_log = CareLog.find_or_initialize_by(
      user: @user,
      plant: @plant,
      date: Date.today
    )
    today_log.quest_done = true
    today_log.quest_response = response if response.present?
    today_log.save!

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
    params.require(:plant).permit(:name, :personality, :color, :pot_style, :accessory)
  end
end
