module ApplicationHelper
  def find_asset(filename)
    assets = Rails.application.assets
    assets.find_asset(filename)
  end

  def embedded_svg(filename, options = {})
    asset_file = find_asset(filename)

    if asset_file
      file = asset_file.source.force_encoding("UTF-8")
      doc = Nokogiri::HTML::DocumentFragment.parse file
      svg = doc.at_css "svg"
      svg["class"] = options[:class] if options[:class].present?
    else
      doc = "<!-- SVG #{filename} not found -->"
    end

    raw doc
  end

  def display_starred_by_emails(stars, show_current_user = true)
    user_emails = stars.map do |star|
      star.user.email
    end

    if show_current_user
      user_emails = user_emails - [current_user.email]
    end

    user_emails.join(", ")
  end
end
