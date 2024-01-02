# frozen_string_literal: true

# rubocop:disable Layout/LineLength
def load_legacy_environment_variables
  # Check for Legacy Environment Variables (to be deprecated)
  deprecations_detected = false

  legacy_options = %i[]

  legacy_options.each do |option|
    next if Settings.send(option).nil?

    Rails.logger.warn("The setting (#{option}) has been moved to the 'pw' section of the settings.yml file.\n" \
                      "Please update your settings.yml file or if using environment variables, change the\n" \
                      "variable name 'PWP__#{option.to_s.upcase}' to 'PWP__PW__#{option.to_s.upcase}'.\n")
    Settings.pw.__send__(:"#{option}=", Settings.send(option))
    deprecations_detected = true
  end

  # Example Usage:
  # # Legacy environment variable: EXPIRE_AFTER_DAYS_DEFAULT
  # # Deprecated in October 2022
  # if ENV.key?('EXPIRE_AFTER_DAYS_DEFAULT')
  #   Rails.logger.warn("The environment variable EXPIRE_AFTER_DAYS_DEFAULT has been deprecated and will be removed in a future version.\n" \
  #                     'Please change this environment variable to PWP__EXPIRE_AFTER_DAYS_DEFAULT or switch to a custom settings.yml entirely.')
  #   Settings.pw.expire_after_days_default = ENV['EXPIRE_AFTER_DAYS_DEFAULT'].to_i
  #   deprecations_detected = true
  # end

  return unless deprecations_detected

  Rails.logger.warn('Deprecations detected: Please see the configuration documentation for the latest updates: https://github.com/pglombardo/PasswordPusher/blob/master/Configuration.md')
end

# Prepend defaults to the Settings object in case users are missing some of the latest settings
Settings.prepend_source!(Rails.root.join('config/settings-defaults.yml').to_s)
Settings.reload!
load_legacy_environment_variables

# rubocop:enable Layout/LineLength
