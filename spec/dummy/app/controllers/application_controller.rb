class ApplicationController < ActionController::Base
  protect_from_forgery

  include RailsTools::I18nController
end
