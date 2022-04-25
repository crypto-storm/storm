// See the Tailwind default theme values here:
// https://github.com/tailwindcss/tailwindcss/blob/master/stubs/defaultConfig.stub.js
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
    './app/views/**/*.haml',
    './lib/jumpstart/app/views/**/*.erb',
    './lib/jumpstart/app/helpers/**/*.rb',
  ],

  // All the default values will be compiled unless they are overridden below
  theme: {
    // Extend (add to) the default theme in the `extend` key
    extend: {
      zIndex: {
        '9999': '9999',
      },
      screens: {
        'hide-location': {'min': '1024px', 'max':'1180px'},
      },
      aspectRatio: {
        cinema: '21 / 9',
      },
      fontSize: {
        '16px': '16px',
        '18px': '18px',
        'very-large': '100px',
        'massive': '80px',
        'xxs': '.40rem',
      },
      height: {
        '100px': '100px',
        '26rem': '26rem',
        '32': '32rem',
        '39': '39rem',
        '52': '52rem',
        '48rem': '48rem',
        '32rem': '32rem',
        '35rem': '35rem',
        '39rem': '39rem',
        '40rem': '40rem',
        '52rem': '52rem',
        '55rem': '55rem'
      },
      spacing: {
        '50px': '50px',
        '100px': '100px',
        '175px': '175px',
      },
      // Create your own at: https://javisperez.github.io/tailwindcolorshades
      colors: {
        primary: colors.blue,
        secondary: colors.emerald,
        tertiary: colors.gray,
        danger: colors.red,
        "code-400": "#fefcf9",
        "code-600": "#3c455b",
        "cine-green": "#7CAE72",
        "cine-green-rollover": "#46803A",
        "cine-gray-rollover": "rgba(255,255,255,0.2)",
        "cine-dark-grey": "#1F1F1F",
        "cine-light-grey": "#AEADAD",
        "cine-very-light-grey": "#F3F3F3"
      },
      fontFamily: {
        sans: ['t26-carbon', ...defaultTheme.fontFamily.sans],
        carbon: ['t26-carbon'],
        knockout: ['knockout']
      },
    },
  },

  // Opt-in to TailwindCSS future changes
  future: {
  },
}
