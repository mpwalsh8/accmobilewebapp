require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ACCMobileWebApp
  class Application < Rails::Application

    # Disable strong params
    #config.action_controller.permit_all_parameters = true
    #config.action_controller.action_on_unpermitted_parameters = :raise

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
        :img => 'webapp/banner/320x50/Apex_Cougar_Club_320x50_Banner.png'
      },
      {
        :name => 'Apex Auto Works',
        :url => 'http://www.apexautoworks.org',
        :img => 'webapp/banner/320x50/Apex_Auto_Works_320x50_Banner.png'
      },
      {
        :name => 'Apex Lions Club',
        :url => 'http://www.apexlions.org',
        :img => 'webapp/banner/320x50/Apex_Lions_Club_320x50_Banner.png'
      },
      {
        :name => 'Apex Rotary Club',
        :url => 'http://www.apexrotary.org',
        :img => 'webapp/banner/320x50/Apex_Rotary_Club_320x50_Banner.png'
      },
      {
        :name => 'Beavers Denistry',
        :url => 'http://www.beaversdenistry.com',
        :img => 'webapp/banner/320x50/Beavers_Dentistry_320x50_Banner.png'
      },
      {
        :name => 'Bovenizer Orthodontics',
        :url => 'http://www.bovorthodontics.com',
        :img => 'webapp/banner/320x50/Bovenizer_Orthodontics_320x50_Banner.png'
      },
      {
        :name => 'Bojangles',
        :url => 'http://www.bojangles.com',
        :img => 'webapp/banner/320x50/Bojangles_320x50_Banner.png'
      },
      {
        :name => 'Bradley Flooring',
        :url => 'http://www.bradleyscarpet.com',
        :img => 'webapp/banner/320x50/Bradley_Flooring_320x50_Banner.png'
      },
      {
        :name => 'Cat Kearns REMAX United',
        :url => 'http://www.catkearns.remaxagent.com',
        :img => 'webapp/banner/320x50/Cat_Kearns_REMAX_320x50_Banner.png'
      },
      {
        :name => 'Chick-Fil-a of Apex',
        :url => 'http://www.chickfila.com',
        :img => 'webapp/banner/320x50/Chick-fil-a_of_Apex_320x50_Banner.png'
      },
      {
        :name => 'CiCi\'s Pizza of Apex',
        :url => 'http://www.cicispizza.com',
        :img => 'webapp/banner/320x50/CiCi_Pizza_of_Apex_320x50_Banner.png'
      },
      {
        :name => 'Fresh Coat Painters',
        :url => 'http://www.freshcoatpainters.net',
        :img => 'webapp/banner/320x50/Fresh_Coat_Painters_320x50_Banner.png'
      },
      {
        :name => 'Hendrick Cary Auto Mall',
        :url => 'http://www.caryautomall.com',
        :img => 'webapp/banner/320x50/Hendrick_Cary_Auto_Mall_320x50_Banner.png'
      },
      {
        :name => 'Hendrick Toyota Scion of Apex',
        :url => 'http://www.hendricktoyotaapex.com',
        :img => 'webapp/banner/320x50/Hendrick_Toyota_Scion_of_Apex_320x50_Banner.png'
      },
      {
        :name => 'Hurricane Grill & Wings',
        :url => 'http://hurricanewings.com/cary',
        :img => 'webapp/banner/320x50/Hurricane_Grill_and_Wings_320x50_Banner.png'
      },
      {
        :name => 'JD\'s Tavern',
        :url => 'http://www.jdstavern.com',
        :img => 'webapp/banner/320x50/JDs_Tavern_320x50_Banner.png'
      },
      {
        :name => 'Kangaroo Express',
        :url => 'http://kangarooexpress.com/StoreHome/846',
        :img => 'webapp/banner/320x50/Kangaroo_Express_320x50_Banner.png'
      },
      {
        :name => 'Kona-Ice',
        :url => 'http://www.kona-ice.com/find-a-kona/local-site/353',
        :img => 'webapp/banner/320x50/Kona_Ice_320x50_Banner.png'
      },
      {
        :name => 'Leith Auto Park Chrysler-Jeep',
        :url => 'http://www.autoparkchryslerjeep.com',
        :img => 'webapp/banner/320x50/Leith_AutoPark_320x50_Banner.png'
      },
      {
        :name => 'L.G. Jordan Oil Co.',
        :url => 'http://www.lgjordanoil.com',
        :img => 'webapp/banner/320x50/LG_Jordan_Oil_Co_320x50_Banner.png'
      },
      {
        :name => 'Locals Guitars',
        :url => 'http://www.localsguitars.com/',
        :img => 'webapp/banner/320x50/Locals_Guitar_320x50_Banner.png'
      },
      {
        :name => 'Luihn Food Systems KFC',
        :url => 'http://www.kfc.com',
        :img => 'webapp/banner/320x50/Luihn_Food_Systems_KFC_320x50_Banner.png'
      },
      {
        :name => 'Luihn Food Systems Taco Bell',
        :url => 'http://www.tacobell.com',
        :img => 'webapp/banner/320x50/Luihn_Food_Systems_Taco_Bell_320x50_Banner.png'
      },
      {
        :name => 'Mathnasium',
        :url => 'http://www.mathnasium.com/apex',
        :img => 'webapp/banner/320x50/Mathnasium_320x50_Banner.png'
      },
      {
        :name => 'McDonalds of Apex',
        :url => 'http://www.mcnorthcarolina.com/17721',
        :img => 'webapp/banner/320x50/McDonalds_of_Apex_320x50_Banner.png'
      },
      {
        :name => 'Money Pages of Cary & Apex',
        :url => 'http://www.moneypages.com/cary-nc-coupons',
        :img => 'webapp/banner/320x50/MoneyPages_320x50_Banner.png'
      },
      {
        :name => 'Mosquito Authority',
        :url => 'http://www.bugsbite.com',
        :img => 'webapp/banner/320x50/Mosquito_Authority_320x50_Banner.png'
      },
      {
        :name => 'Perfect Promotions',
        :url => 'http://www.perfect-promos.com',
        :img => 'webapp/banner/320x50/Perfect_Promotions_320x50_Banner.png'
      },
      {
        :name => 'Red Robin',
        :url => 'http://www.redrobin.com',
        :img => 'webapp/banner/320x50/Red_Robin_320x50_Banner.png'
      },
      {
        :name => 'Rudinos Sports Porch of Apex',
        :url => 'http://www.rudinos.com/sports_porch',
        :img => 'webapp/banner/320x50/Rudinos_Sports_Porch_320x50_Banner.png'
      },
      {
        :name => 'Scruffy Duck',
        :url => 'http://www.scruffy-duck.com',
        :img => 'webapp/banner/320x50/Scruffy_Duck_320x50_Banner.png'
      },
      {
        :name => 'The Skin Institute',
        :url => 'http://www.tsiskin.com',
        :img => 'webapp/banner/320x50/The_Skin_Institute_320x50_Banner.png'
      },
      {
        :name => 'Spielberg Orthodontics',
        :url => 'http://www.spielberg-ortho.com',
        :img => 'webapp/banner/320x50/Spielberg_Ortho_320x50_Banner.png'
      },
      {
        :name => 'SportHQ',
        :url => 'http://www.sporthq.org',
        :img => 'webapp/banner/320x50/SportHQ_320x50_Banner.png'
      },
      {
        :name => 'Sports Clips Haircuts',
        :url => 'http://haircutmenmorrisvillenc.com',
        :img => 'webapp/banner/320x50/Sport_Clips_320x50_Banner.png'
      },
      {
        :name => 'Triangle Eye Institute',
        :url => 'http://www.tei2020.com',
        :img => 'webapp/banner/320x50/Triangle_Eye_Institute_320x50_Banner.png'
      },
      {
        :name => 'Trubute Pizza',
        :url => 'http://www.tributepizzaplace.com',
        :img => 'webapp/banner/320x50/Tribute_Pizza_320x50_Banner.png'
      },
      {
        :name => 'Triangle Orthopaedics',
        :url => 'http://www.triangleortho.com',
        :img => 'webapp/banner/320x50/Triangle_Orthopaedics_320x50_Banner.png'
      }
    ]

    SPLASHADS = [
     # {
     #   :name => 'Bojangles',
     #   :url => 'http://www.bojangles.com',
     #   :img => 'webapp/splash/Bojangles_320x420_Splash.png'
     # },
      {
        :name => 'Chick-Fil-a of Apex',
        :url => 'http://www.chickfila.com',
        :img => 'webapp/splash/Chick-fil-a_of_Apex_320x420_Splash.png'
      },
      {
        :name => 'Kona-Ice',
        :url => 'http://www.kona-ice.com/find-a-kona/local-site/353',
        :img => 'webapp/splash/Kona_Ice_320x420_Splash.png'
      },
      {
        :name => 'Hendrick Cary Auto Mall',
        :url => 'http://www.caryautomall.com',
        :img => 'webapp/splash/Hendrick_Cary_Auto_Mall_320x420_Splash.png'
      },
      {
        :name => 'JD\'s Tavern',
        :url => 'http://www.jdstavern.com',
        :img => 'webapp/splash/JDs_Tavern_320x420_Splash.png'
      },
      {
        :name => 'NC State Fair',
        :url => 'http://www.ncstatefair.org/2014/index.htm',
        :img => 'webapp/splash/NCSF2014_320x420_Splash.png'
      },
      {
        :name => 'T.MAC',
        :url => 'http://tmacrestaurants.com/location/cary/',
        :img => 'webapp/splash/TMAC_320x420_Splash.png'
      },
    ]

  end
end
