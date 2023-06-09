namespace :db do
  desc 'Load seed data into the database'
  task load_seeds: :environment do
    seed_file = File.join(Rails.root, 'db', 'seeds.rb')
    load(seed_file) if File.exist?(seed_file)
  end
end