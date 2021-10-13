require "open-uri"

class CranService
  CRAN_SERVERS = [
    "https://cran.r-project.org",
    "https://rweb.crmda.ku.edu/cran"
  ].freeze

  CRAN_PATH = "src/contrib"
  CRAN_PACKAGE_PATH = "#{CRAN_PATH}/PACKAGES"
  CRAN_PACKAGE_EXTENSION = "tar.gz"

  class << self
    def list_packages(...)
      content = URI.parse(list_path(...)).read
      parse_response(content)
    end

    def get_package(...)
      URI.parse(package_path(...)).read
    end

    private

    def list_path(server: 0)
      "#{CRAN_SERVERS[server]}/#{CRAN_PACKAGE_PATH}"
    end

    def package_path(server: 0, name_and_version:)
      "#{CRAN_SERVERS[server]}/#{CRAN_PATH}/#{name_and_version}.#{CRAN_PACKAGE_EXTENSION}"
    end

    def parse_response(...)
      CranPackageParserService.parse(...)
    end
  end
end
