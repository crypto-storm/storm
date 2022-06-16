const colors = require('tailwindcss/colors')
const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  plugins: [
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/forms')({ strategy: 'class' }),
    require('@tailwindcss/line-clamp'),
    require('@tailwindcss/typography'),
  ],

  content: [
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.erb',
  ],

  theme: {
    extend: {
      colors: {
        primary: colors.blue,
        secondary: colors.emerald,
        tertiary: colors.gray,
        danger: colors.red,
        "dark-600": "#414a6c",
        "dark-700": "#2e3348",
        "dark-800": "#202231",
        "dark-900": "#161522",
        "dark-1000": "#0d0415",
      },
    },
  },
}
