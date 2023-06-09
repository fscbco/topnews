let environment = {
  plugins: [
    require("tailwindcss")("./app/javascript/stylesheets/tailwind.config.js"),
    require("autoprefixer"),
    require("postcss-import"),
  ]
};

module.exports = environment;