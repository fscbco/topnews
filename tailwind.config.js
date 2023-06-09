/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {},
  plugins: [
    require('@catppuccin/tailwindcss')({
      // prefix to use, e.g. `text-pink` becomes `text-ctp-pink`.
      // default is `false`, which means no prefix
      // which flavour of colours to use by default, in the `:root`
      defaultFlavour: 'macchiato',
    }),
  ]
}