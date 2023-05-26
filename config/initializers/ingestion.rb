require 'rufus-scheduler'

Rufus::Scheduler.singleton.every '15m' do
	Story.ingest
end
