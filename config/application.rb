require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ACCMobileWebApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    BANNERADS = [
      {
        :name => 'Apex Cougar Club',
        :url => 'http://www.apexcougarclub.org/corporate-sponsorship/',
        :img => 'webapp/banner/Apex_Cougar_Club_320x50.svg'
      },
      {
        :name => 'Kona-Ice',
        :url => 'http://www.kona-ice.com',
        :img => 'webapp/banner/Kona_Ice_320x50.svg'
      },
      {
        :name => 'Sports Clips Haircuts',
        :url => 'http://haircutmenmorrisvillenc.com/',
        :img => 'webapp/banner/Sport_Clips_320x50.svg'
      }
    ]
    SPLASHADS = [
    ]

  end
end
