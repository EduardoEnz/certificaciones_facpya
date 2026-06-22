require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CertificacionesFacpya
  class Application < Rails::Application
    config.i18n.default_locale = :es
    config.i18n.available_locales = [:es, :en]
  end
end
