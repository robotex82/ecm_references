module ActiveAdmin
  module Devise
    class SessionsController
      def after_sign_out_path_for(resource_or_scope)
        return "/#{I18n.locale}"
      end
    end
  end
end

