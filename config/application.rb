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
        :url => 'http://www.kona-ice.com/find-a-kona/local-site/353',
        :img => 'webapp/banner/Kona_Ice_320x50.svg'
      },
      {
        :name => 'Sports Clips Haircuts',
        :url => 'http://haircutmenmorrisvillenc.com/',
        :img => 'webapp/banner/Sport_Clips_320x50.svg'
      },
      {
        :name => 'Spielberg Orthodontics',
        :url => 'http://www.spielberg-ortho.com/',
        :img => 'webapp/banner/Spielberg_Ortho_320x50.png'
      },
      {
        :name => 'Apex Lions Club',
        :url => 'http://www.apexlions.org/',
        :img => 'webapp/banner/Apex_Lions_Club_320x50.svg'
      },
      {
        :name => 'Apex Rotary Club',
        :url => 'http://www.apexrotary.org/',
        :img => 'webapp/banner/Apex_Rotary_Club_320x50.svg'
      },
      {
        :name => 'Beavers Denistry',
        :url => 'http://www.beaversdenistry.com/',
        :img => 'webapp/banner/Beavers_Denistry_320x50.svg'
      },
      {
        :name => 'Bo Jangles',
        :url => 'http://www.bojangles.com/',
        :img => 'webapp/banner/Bo_Jangles_320x50.svg'
      },
      {
        :name => 'Bradley Flooring',
        :url => 'http://www.bradleyscarpet.com/',
        :img => 'webapp/banner/Bradley_Flooring_320x50.svg'
      },
      {
        :name => 'Cat Kearns REMAX United',
        :url => 'http://www.catkearns.remaxagent.com/',
        :img => 'webapp/banner/Cat_Kearns_REMAX_320x50.svg'
      },
      {
        :name => 'Chick-Fil-a of Apex',
        :url => 'http://www.chickfila.com/',
        :img => 'webapp/banner/Chick-Fil-A_of_Apex_320x50.svg'
      },
      {
        :name => 'Cici\'s Pizza of Apex',
        :url => 'http://www.cicispizza.com/',
        :img => 'webapp/banner/Cici_Pizza_of_Apex_320x50.svg'
      },
      {
        :name => 'fresh Coat Painters',
        :url => 'http://www.spielberg-ortho.com/',
        :img => 'webapp/banner/Spielberg_Ortho_320x50.svg'
      }
    ]
    SPLASHADS = [
    ]

  end
end
