class ApplicationController < ActionController::Base
  
  include SessionsHelper

  #cross site request forgery (CSRF) - feature makes all generated forms have a hidden id.
  protect_from_forgery
end
