# frozen_string_literal: true

class Story < ApplicationRecord
  serialize :raw_data, Hash
end
