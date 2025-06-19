# lib/mood_library.rb

module MoodLibrary
  MESSAGES = {
    "joyeuse" => [
      "Je me sens photosynthétiquement heureuse ☀️",
      "C’est une belle journée pour être arrosée 🌼",
      "On forme une super équipe, toi et moi 🍀"
    ],
    "agressive" => [
      "Je suis peut-être verte, mais j’suis pas tendre 🐍",
      "T’as cliqué trop fort. J’ai senti ton agressivité.",
      "Encore toi ? Bon. Pas touche à mes feuilles."
    ],
    "mélancolique" => [
      "Parfois j’ai l’impression de faner dans ton indifférence… 🌧️",
      "J’ai contemplé le vide du pot, et il m’a parlé.",
      "Chaque goutte d’eau me rappelle ta négligence 😔"
    ],
    "ironique" => [
      "Oh. Te voilà. T’as perdu ton chargeur ou quoi ? 😏",
      "Trop cool, t’es revenu. Je m’y attendais TELLEMENT.",
      "J’ai failli lancer un syndicat des plantes oubliées."
    ],
    "neutre" => [
      "Je sais pas trop ce que je ressens. De l’engrais, peut-être.",
      "J’existe, c’est déjà pas mal.",
      "Un jour, je comprendrai pourquoi je suis dans ce pot."
    ]
  }

  def self.random_message_for(mood)
    (MESSAGES[mood] || MESSAGES["neutre"]).sample
  end
end
