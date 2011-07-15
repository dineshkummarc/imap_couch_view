class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :connect_couchdb

  def connect_couchdb
    @@db = COUCHDB
  end
end
