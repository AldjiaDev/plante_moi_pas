// tailwind.config.js
module.exports = {
  content: [
    "./app/views/**/*.{html.erb,html,js}",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
  ],
  theme: {
    extend: {
      colors: {
        plante: {
          DEFAULT: '#4CAF50',
          clair: '#E8F5E9',
          fonce: '#2E7D32',
        },
      },
      fontFamily: {
        sans: ['Inter', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
