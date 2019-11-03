// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")

require("lib/angular.min")
require("lib/angular-route.min")
require("lib/angular-sanitize.min")
require("lib/angular-resource.min")
require("lib/array.coffee")

require("src/app_angular.coffee")

require("src/controllers/board_ctrl.coffee")
require("src/resources/board.coffee")

require("src/controllers/step_ctrl.coffee")
require("src/resources/step.coffee")

require("src/controllers/task_ctrl.coffee")
require("src/resources/task.coffee")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
