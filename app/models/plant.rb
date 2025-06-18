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

    :watered
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

    :quest_completed
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
