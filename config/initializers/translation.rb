# Permitted locales available for the application
I18n.available_locales = %i[de en es it nl pl sr]

# Set default locale to something other than :en
I18n.default_locale = :en

TranslationIO.configure do |config|
  config.api_key        = 'cc6a66a15e02433aa9d0afeb39835b8c'
  config.source_locale  = 'en'
  config.target_locales = %i[de es it nl pl sr]

  # Uncomment this if you don't want to use gettext
  # config.disable_gettext = true

  # Uncomment this if you already use gettext or fast_gettext
  # config.locales_path = File.join('path', 'to', 'gettext_locale')

  # Find other useful usage information here:
  # https://github.com/translation/rails#readme
end

