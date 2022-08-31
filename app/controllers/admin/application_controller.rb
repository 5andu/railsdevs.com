module Admin
  class ApplicationController < ApplicationController
    # before_action :authenticate_user!
    before_action :require_admin!

    protected

    def require_admin!
      unless signed_in? && true_user.admin?
        raise ActionController::RoutingError.new("Not Found")
      end
    end
  end
end
