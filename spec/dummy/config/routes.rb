Dummy::Application.routes.draw do
  localized(I18n.available_locales) do
    scope "/(:i18n_locale)", :constraints => {:i18n_locale => /#{I18n.available_locales.join('|')}/} do
      devise_for :admin_users, ActiveAdmin::Devise.config
      ActiveAdmin.routes(self)

      Ecm::References::Routing.routes(self)

      # Prevent errors, when using root_path
      root :to => 'home#index'
    end # scope
  end # localized
end # Dummy::Application.routes.draw

