require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "rails/test_unit/railtie"

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module ImapCouchView
  class Application < Rails::Application
    config.i18n.default_locale = :de
    config.action_view.javascript_expansions[:defaults] = %w(jquery rails)
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
  end
end

couch = CouchRest.new('http://localhost:5984')
COUCHDB = couch.database!('infopark-email')
VIEW_NAME = '_design/imap_couch_import/_view/by_from_and_to'
