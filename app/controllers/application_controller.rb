class ApplicationController < ActionController::Base

  before_filter :TwitterSetup

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  ##  Commented out 8/8 to stop CSRF errors - MPW
  #protect_from_forgery with: :exception

  ##  Twitter Gem Support
  def TwitterSetup
    @TwitterClient = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret = ENV["TWITTER_CONSUMER_SECRET"]
      #config.oauth_token = ENV["TWITTER_OAUTH_TOKEN"]
      #config.oauth_token_secret = ENV["TWITTER_OAUTH_TOKEN_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
    end
  end

end
