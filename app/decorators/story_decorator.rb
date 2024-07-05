# frozen_string_literal: true

class StoryDecorator < Draper::Decorator
  delegate_all

  def created_on
    Time.at( object.time ).to_date
  end

  def flagged_by
    object.users.pluck( :first_name ).to_sentence
  end

  def flagged_count
    object.users.size
  end
end
