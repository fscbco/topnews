desc 'Seeds the Feed table from our news source(s)'
task :feed do
  puts "Seeding the feeds table, make sure you've created and migrated your database prior to running this task!"
  puts "Running..."
  PullFeedsJob.new.perform
  puts "Done! The feeds table now as #{Feed.count} entries."
end
