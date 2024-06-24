# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "rails-ujs", to: "rails-ujs.js"
pin "bootstrap", to: "bootstrap.min.js"
pin "popper", to: "popper.min.js"
pin_all_from "app/javascript/controllers", under: "controllers"
