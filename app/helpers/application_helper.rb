# frozen_string_literal: true

module ApplicationHelper
  # Set the HTML title for the page with a trailing site identifier.
  def title(content)
    content_for(:html_title) { "#{content} | #{Settings.brand.title}" }
  end

  # Set the HTML title for the page _without_ the trailing site identifier.
  # Used in Password#show/show_expired to hide Password Pusher branding
  def plain_title(content)
    content_for(:html_title) { content }
  end

  # Used in the topname to set the active tab
  def current_controller?(names)
    names.include?(params[:controller])
  end

  # Constructs a fully qualified secret URL for a push.
  #
  # @param [Password, Url, FilePush] password - The push to generate a URL for
  # @param [Boolean] with_retrieval_step - Whether to include the retrieval step in the URL
  # @return [String] - The fully qualified URL
  def secret_url(password, with_retrieval_step: true)
    raw_url = if password.retrieval_step && with_retrieval_step
      case password
      when Password
        Settings.override_base_url ? preliminary_password_url(password, host: Settings.override_base_url) : preliminary_password_url(password)
      when Url
        Settings.override_base_url ? preliminary_url_url(password, host: Settings.override_base_url) : preliminary_url_url(password)
      when FilePush
        Settings.override_base_url ? preliminary_file_push_url(password, host: Settings.override_base_url) : preliminary_file_push_url(password)
      else
        raise "Unknown push type: #{password.class}"
      end
    else
      case password
      when Password
        Settings.override_base_url ? password_url(password, host: Settings.override_base_url) : password_url(password)
      when Url
        Settings.override_base_url ? url_url(password, host: Settings.override_base_url) : url_url(password)
      when FilePush
        Settings.override_base_url ? file_push_url(password, host: Settings.override_base_url) : file_push_url(password)
      else
        raise "Unknown push type: #{password.class}"
      end
    end

    # Delete any existing ?locale= query parameter
    raw_url = raw_url.split("?").first

    if params["push_locale"].present? && Settings.enabled_language_codes.include?(params["push_locale"])
      # Append the locale query parameter
      raw_url += "?locale=#{params["push_locale"]}"
    end

    # Support forced https links with FORCE_SSL env var
    raw_url.gsub!(/http/i, "https") if ENV.key?("FORCE_SSL") && !request.ssl?
    raw_url
  end

  # qr_code
  #
  # Generates a QR code for the given URL
  #
  # @param [String] url - The URL to generate the QR code for
  # @return [String] - The SVG QR code
  def qr_code(url)
    RQRCode::QRCode.new(url).as_svg(
      offset: 0,
      color: :currentColor,
      shape_rendering: "crispEdges",
      module_size: 6,
      standalone: true
    ).html_safe
  end
end
