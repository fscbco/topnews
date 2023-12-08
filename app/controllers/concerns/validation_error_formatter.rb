# simple concern to format dry-validation errors
# for display
module ValidationErrorFormatter
  extend ActiveSupport::Concern

  included do
    helper_method :format_errors_for_flash
  end

  def format_errors_for_flash(object)
    flash_errors = []
    object.errors.each do |error|
      flash_errors << "#{error.path.join('/')}: #{error.text}"
    end

    flash[:alert] = flash_errors.join(', ')
  end
end

