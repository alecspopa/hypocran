class Package < ApplicationRecord
  has_many :package_versions

  def version_url(version)
    "#{name}_#{version}"
  end
end
