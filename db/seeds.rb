# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Achievement.create!(
  code: "water_5_days",
  name: "Routine en herbe",
  description: "Tu m’as arrosée 5 jours d’affilée. Est-ce… de l’amour ?"
)

Achievement.create!(
  code: "quest_10_completed",
  name: "Missionnaire végétal",
  description: "Tu as complété 10 de mes caprices quotidiens. T'es solide."
)

Achievement.create!(
  code: "revived_after_death",
  name: "Tu reviens toujours",
  description: "Tu m’as laissée mourir… puis tu es revenu(e). Je te pardonne. Peut-être."
)
