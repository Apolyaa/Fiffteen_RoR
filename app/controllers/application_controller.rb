class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :require_login
  
    include SessionHelper
  
    private
  
    def require_login
      unless signed_in?
        flash[:danger] = "Вы должны войти"
        redirect_to session_login_path
      end
    end

    around_action :switch_locale

    private

    def switch_locale(&action)
      locale = locale_from_url || I18n.default_locale
      I18n.with_locale locale, &action
    end

    def locale_from_url
      locale = params[:locale]
      return locale if I18n.available_locales.map(&:to_s).include?(locale)
      nil
    end

    def default_url_options
      {locale: I18n.locale}
    end
end
