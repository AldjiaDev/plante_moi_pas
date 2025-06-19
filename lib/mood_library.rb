module MoodLibrary
  PACKS = {
    "default" => {
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
      ]
    },
    "drama" => {
      "joyeuse" => [
        "Enfin ! Ma lumière, mon soleil, mon arroseur 😩✨",
        "Tu es revenu… Je croyais ce jour perdu à jamais 😭",
        "Chaque goutte d’eau est une larme de bonheur 💧❤️"
      ],
      "mélancolique" => [
        "Tu m’as laissée. Je me suis fanée d’amour…",
        "J’étais une tragédie botanique, seule au monde.",
        "Ma terre est sèche comme mon cœur. Bravo."
      ]
    },
    "zen" => {
      "joyeuse" => [
        "Merci. Comme l’eau coule, ainsi va la paix 🍵",
        "Ma croissance est lente, mais certaine 🌿",
        "Arroser, c’est méditer pour deux."
      ],
      "agressive" => [
        "Même un cactus peut se blesser. Doucement 🙏",
        "Respire. Moi je suis une plante, pas un boss final.",
        "La colère dessèche plus que le soleil."
      ]
    }
  }

  def self.random_message_for(mood, personality = nil)
    pack = PACKS[personality] || PACKS["default"]
    (pack[mood] || PACKS["default"][mood] || PACKS["default"]["joyeuse"]).sample
  end
end
