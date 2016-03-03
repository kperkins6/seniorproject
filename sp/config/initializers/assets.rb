# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( 
controllers/TagsController_spec.self.js
spec_helper.self.js
  teaspoon.css
  teaspoon-teaspoon.js
  teaspoon-jasmine.js
  support/phantomjs-shims.self.js
  jquery/dist/jquery.self.js
  jquery_ujs.self.js
  turbolinks.self.js
angular/angular.self.js
angular-route/angular-route.self.js
angular-resource/angular-resource.self.js
angular-rails-templates.self.js
app.self.js
business_cards.self.js
templates/index.self.js
application.self.js
angular-mocks/angular-mocks.self.js
support/phantomjs-shims.self.js
)
# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
