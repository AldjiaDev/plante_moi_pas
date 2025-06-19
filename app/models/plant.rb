class Plant < ApplicationRecord
  belongs_to :user
  has_many :plant_logs, dependent: :destroy

  def water_today!
    today = Date.current

    # Vérifie s'il y a déjà un log pour aujourd'hui
    log = plant_logs.find_or_initialize_by(date: today)

    return :already_watered if log.watered?

    # Marque comme arrosé
    log.watered = true
    log.quest_done ||= false

    # Gestion des jours consécutifs
    if last_watered_at&.to_date == today - 1
      self.consecutive_days_watered += 1
    else
      self.consecutive_days_watered = 1
    end

    self.last_watered_at = Time.current

    # Mise à jour humeur/état
    evaluate_mood!

    # On stocke l’humeur du jour dans le log
    log.mood = mood
    log.save!

    save!

    check_achievements!

    :watered
    update_growth_stage!
  end

  def do_quest_today!(reward_points = 3)
    today = Date.current
    log = plant_logs.find_or_initialize_by(date: today)

    return :already_done if log.quest_done?

    log.quest_done = true
    log.save!

    self.leaves ||= 0
    self.leaves += reward_points
    save!

    check_achievements!

    :quest_completed
  end

  def daily_log
    plant_logs.find_or_create_by(date: Date.current)
  end

  def assign_daily_quest!
    log = daily_log
    return log.quest if log.quest.present?

    quest = Quest.where(active: true).order("RANDOM()").first
    log.update!(quest: quest)

    quest
  end

  def submit_quest_response!(response)
    log = daily_log

    return :no_quest unless log.quest
    return :invalid_type unless log.quest.quest_type == "text_input"
    return :already_done if log.quest_done?

    log.quest_response = response
    log.quest_done = true
    log.save!

    self.leaves ||= 0
    self.leaves += log.quest.reward_points
    save!

    :quest_completed
  end

  def check_achievements!
    user = self.user

    unlock = ->(code) do
      achievement = Achievement.find_by(code: code)
      return if user.achievements.include?(achievement)
      UserAchievement.create!(user: user, achievement: achievement, unlocked_at: Time.current)
    end

    unlock.call("water_5_days") if consecutive_days_watered >= 5
    unlock.call("quest_10_completed") if plant_logs.where(quest_done: true).count >= 10
    unlock.call("revived_after_death") if state == "active" && previous_state_was_gone?
  end

  def previous_state_was_gone?
    plant_logs.order(date: :desc).limit(5).any? do |log|
      log.mood == "partie"
    end
  end

  def update_growth_stage!
    stage =
      case consecutive_days_watered
      when 0..2 then "sprout"
      when 3..4 then "leafy"
      when 5..6 then "bushy"
      else "tree"
      end

    update!(growth_stage: stage)
  end


  private

  def evaluate_mood!
    days_since_watered = (Date.current - (last_watered_at&.to_date || Date.current)).to_i

    case days_since_watered
    when 0
      self.mood = (consecutive_days_watered > 1) ? "joyeuse" : "ironique"
      self.state = "active"
    when 1..2
      self.mood = "mélancolique"
      self.state = "dry"
    when 3..4
      self.mood = "agressive"
      self.state = "dry"
    else
      self.mood = "partie"
      self.state = "gone"
    end
  end
end
