namespace :utils do
  desc "Schedules a job to reindex new CRAN packages"

  task cran_indexer: :environment do
    server_number = (0...CranService::CRAN_SERVERS.size).to_a.sample
    CranPackageIndexerJob.perform_later(server_number)
  end
end
