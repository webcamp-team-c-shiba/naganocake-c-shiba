class ApplicationController < ActionController::Base
  
  add_flash_types :success, :info, :warning, :danger
  
    before_action :authenticate_customer!
end
