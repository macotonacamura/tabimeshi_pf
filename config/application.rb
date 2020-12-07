require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tabimeshi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.time_zone = 'Asia/Tokyo'
    config.i18n.default_locale = :ja
    #config.i18n.enforce_available_locales = true
    I18n.available_locales = [:fr, :de, :es, :en, :ja, :it, :ko, :da, :el, :et, :ru,]
    config.autoload_paths += Dir[Rails.root.join('app', 'uploaders')]

    # 翻訳ファイルのディレクトを追加
    #config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
