# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Achievement.find_or_create_by!(
  code: "water_5_days"
) do |a|
  a.name = "Routine en herbe"
  a.description = "Tu m’as arrosée 5 jours d’affilée. Est-ce… de l’amour ?"
end

Achievement.find_or_create_by!(
  code: "quest_10_completed"
) do |a|
  a.name = "Missionnaire végétal"
  a.description = "Tu as complété 10 de mes caprices quotidiens. T'es solide."
end

Achievement.find_or_create_by!(
  code: "revived_after_death"
) do |a|
  a.name = "Tu reviens toujours"
  a.description = "Tu m’as laissée mourir… puis tu es revenu(e). Je te pardonne. Peut-être."
end

# Crée ou récupère l'utilisateur
user = User.find_or_create_by!(email: "test@example.com") do |u|
  u.password = "password"
end

# Supprime la plante existante si elle existe
user.plant&.destroy

# Crée une nouvelle plante avec personnalité
user.create_plant!(
  name: "Bambou",
  mood: "joyeuse",
  state: "active",
  leaves: 0,
  consecutive_days_watered: 1,
  last_watered_at: Time.current,
  growth_stage: "sprout",
  personality: "drama"
)

# Crée un log du jour (uniquement s’il n'existe pas)
user.plant.plant_logs.find_or_create_by!(date: Date.today) do |log|
  log.watered = true
  log.quest_done = false
end

puts "✅ Seeded user and dramatic plant!"
