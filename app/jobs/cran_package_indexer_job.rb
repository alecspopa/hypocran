class CranPackageIndexerJob < ApplicationJob
  queue_as :default

  def perform(server_number)
    packages = list_packages(server_number)
    packages.each do
      CranPackageSaveJob.perform_later(server_number, _1.path)
    end
  end

  private

  def list_packages(server_number)
    CranService.list_packages(server: server_number)
  end
end
