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
        :url => 'http://www.apexcougarclub.org/corporate-sponsorship',
        :img => 'webapp/banner/Apex_Cougar_Club_320x50.svg'
      },
      {
        :name => 'Apex Lions Club',
        :url => 'http://www.apexlions.org',
        :img => 'webapp/banner/Apex_Lions_Club_320x50.svg'
      },
      {
        :name => 'Apex Rotary Club',
        :url => 'http://www.apexrotary.org',
        :img => 'webapp/banner/Apex_Rotary_Club_320x50.svg'
      },
      {
        :name => 'Beavers Denistry',
        :url => 'http://www.beaversdenistry.com',
        :img => 'webapp/banner/Beavers_Denistry_320x50.svg'
      },
      {
        :name => 'Bovenizer Orthodontics',
        :url => 'http://www.bovorthodontics.com',
        :img => 'webapp/banner/Bovenizer_Orthodontics_320x50_Banner.svg'
      },
      {
        :name => 'Bojangles',
        :url => 'http://www.bojangles.com',
        :img => 'webapp/banner/Bojangles_320x50.svg'
      },
      {
        :name => 'Bradley Flooring',
        :url => 'http://www.bradleyscarpet.com',
        :img => 'webapp/banner/Bradley_Flooring_320x50.svg'
      },
      {
        :name => 'Cat Kearns REMAX United',
        :url => 'http://www.catkearns.remaxagent.com',
        :img => 'webapp/banner/Cat_Kearns_REMAX_320x50.svg'
      },
      {
        :name => 'Chick-Fil-a of Apex',
        :url => 'http://www.chickfila.com',
        :img => 'webapp/banner/Chick-Fil-A_of_Apex_320x50.svg'
      },
      {
        :name => 'CiCi\'s Pizza of Apex',
        :url => 'http://www.cicispizza.com',
        :img => 'webapp/banner/CiCi_Pizza_of_Apex_320x50.svg'
      },
      {
        :name => 'Fresh Coat Painters',
        :url => 'http://www.freshcoatpainters.net',
        :img => 'webapp/banner/Fresh_Coat_Painters_320x50.svg'
      },
      {
        :name => 'Hendrick Cary Auto Mall',
        :url => 'http://www.caryautomall.com',
        :img => 'webapp/banner/Hendrick_Cary_Auto_Mall_320x50.svg'
      },
      {
        :name => 'Hendrick Toyota Scion of Apex',
        :url => 'http://www.hendricktoyotaapex.com',
        :img => 'webapp/banner/Hendrick_Toyota_Scion_of_Apex_320x50.svg'
      },
      {
        :name => 'Hurricane Grill & Wings',
        :url => 'http://hurricanewings.com/cary',
        :img => 'webapp/banner/Hurricane_Grill_and_Wings_320x50_Banner.svg '
      },
      {
        :name => 'JD\'s Tavern',
        :url => 'http://www.jdstavern.com',
        :img => 'webapp/banner/JDs_Tavern_320x50.svg'
      },
      {
        :name => 'Kangaroo Express',
        :url => 'http://kangarooexpress.com/StoreHome/846',
        :img => 'webapp/banner/Kangaroo_Express_320x50_Banner.svg'
      },
      {
        :name => 'Kona-Ice',
        :url => 'http://www.kona-ice.com/find-a-kona/local-site/353',
        :img => 'webapp/banner/Kona_Ice_320x50.svg'
      },
      {
        :name => 'L.G. Jordan Oil Co.',
        :url => 'http://www.lgjordanoil.com',
        :img => 'webapp/banner/LGJordan_Oil_Co_320x50.svg'
      },
      {
        :name => 'Luihn Food Systems KFC',
        :url => 'http://www.kfc.com',
        :img => 'webapp/banner/Luihn_Food_Systems_KFC_320x50.svg'
      },
      {
        :name => 'Luihn Food Systems Taco Bell',
        :url => 'http://www.tacobell.com',
        :img => 'webapp/banner/Luihn_Food_Systems_Taco_Bell_320x50.svg'
      },
      {
        :name => 'McDonalds of Apex',
        :url => 'http://www.mcnorthcarolina.com/17721',
        :img => 'webapp/banner/McDonalds_of_Apex_320x50.svg'
      },
      {
        :name => 'Metcalf Painting & Interiors',
        :url => 'http://www.metcalfpainting.com',
        :img => 'webapp/banner/Metcalf_Painting_320x50.svg'
      },
      {
        :name => 'Mosquito Authority',
        :url => 'http://www.bugsbite.com',
        :img => 'webapp/banner/Mosquito_Authority_320x50.svg'
      },
      {
        :name => 'Perfect Promotions',
        :url => 'http://www.perfect-promos.com',
        :img => 'webapp/banner/Perfect_Promotions_320x50.svg'
      },
      {
        :name => 'Red Robin',
        :url => 'http://www.redrobin.com',
        :img => 'webapp/banner/Red_Robin_320x50.svg'
      },
      {
        :name => 'Scruffy Duck',
        :url => 'http://www.scruffy-duck.com',
        :img => 'webapp/banner/Scruffy_Duck_320x50.svg'
      },
      {
        :name => 'The Skin Institute',
        :url => 'http://www.tsiskin.com',
        :img => 'webapp/banner/The_Skin_Institute_320x50.svg'
      },
      {
        :name => 'Spielberg Orthodontics',
        :url => 'http://www.spielberg-ortho.com',
        :img => 'webapp/banner/Spielberg_Ortho_320x50.png'
      },
      {
        :name => 'Sports Clips Haircuts',
        :url => 'http://haircutmenmorrisvillenc.com',
        :img => 'webapp/banner/Sport_Clips_320x50.svg'
      },
      {
        :name => 'Triangle Eye Institute',
        :url => 'http://www.tei2020.com',
        :img => 'webapp/banner/Triangle_Eye_Institute_320x50.svg'
      },
      {
        :name => 'Triangle Orthopaedics',
        :url => 'http://www.triangleortho.com',
        :img => 'webapp/banner/Triangle_Orthopaedics_320x50.svg'
      }
    ]
    SPLASHADS = [
    ]

  end
end
