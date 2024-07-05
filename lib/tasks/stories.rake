# frozen_string_literal: true

namespace :stories do
  desc "Stories task"

  task import: :environment do
    puts "Importing story"

    ::Stories::ImportService.run!
  end
end
