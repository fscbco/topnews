class Story < ApplicationRecord
    #With these validations in place, if a user tries to create or update a story without providing a title 
    #or a URL, the model will prevent the record from being saved and return an error 
    #message indicating the missing attribute. Similarly, if the URL provided by 
    #the user does not match the valid format, the validation will prevent the invalid URL from being saved.
    validates :title, presence: true
    validates :url, presence: true

    has_many :flags, class_name: 'Flag'
    has_many :flagging_users, through: :flags, source: :user

    # Custom validation: URL format
    validate :validate_url_format

    private

    def validate_url_format
        return if url.blank? # Skip validation if the URL is blank

        # Use a regular expression to check if the URL has a valid format
        url_regex = /\Ahttps?:\/\/\S+\z/
        unless url.match?(url_regex)
        errors.add(:url, "is not a valid URL format")
        end
    end
end
