require 'login_engine'

class ApplicationController < ActionController::Base
  include LoginEngine
  helper :user
  model :user

end