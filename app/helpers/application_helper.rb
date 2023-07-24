module ApplicationHelper
  def embedded_svg(filename, options = {})
    assets = Rails.application.assets
    asset = assets.find_asset(filename)

    if asset
      file = asset.source.force_encoding("UTF-8")
      doc = Nokogiri::HTML::DocumentFragment.parse file
      svg = doc.at_css "svg"
      svg["class"] = options[:class] if options[:class].present?
    else
      doc = "<!-- SVG #{filename} not found -->"
    end

    raw doc
  end

  def display_starred_by_emails_without_current_user(stars)
    user_emails = stars.map do |star|
      star.user.email
    end - [current_user.email]

    user_emails.join(", ")
  end

  def display_starred_by_emails(stars)
    user_emails = stars.map do |star|
      star.user.email
    end

    user_emails.join(", ")
  end
end
