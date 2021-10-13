require "rubygems/package"
require "zlib"

class CranPackageSaveJob < ApplicationJob
  queue_as :default

  def perform(server_number, path)
    content = get_package(server_number, path)
    parse_and_save_package(content)
  end

  private

  def get_package(server_number, path)
    CranService.get_package(server: server_number, name_and_version: path)
  end

  def parse_and_save_package(content)
    file_content = StringIO.new(content)

    tar_extract = Gem::Package::TarReader.new(Zlib::GzipReader.new(file_content))
    tar_extract.rewind

    tar_extract.each do |entry|
      if entry.full_name.match?(/DESCRIPTION/)
        pack = CranPackageDescriptionParserService.parse(entry.read)
        save_package(pack)
      end
    end

    tar_extract.close
  end

  def save_package(pack)
    package = Package.find_or_create_by!(name: pack.name) do |entity|
      entity.title = pack.title
      entity.description = pack.description
    end

    PackageVersion.find_or_create_by!(package: package, name: pack.version)
  end
end
