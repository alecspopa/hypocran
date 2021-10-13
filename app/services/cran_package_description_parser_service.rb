class CranPackageDescriptionParserService
  Package = Struct.new(:name, :title, :version, :description)

  def self.parse(content)
    name = content.match(/Package\:\s(.*)/).captures.first
    title = content.match(/Title\:\s(.*)/).captures.first
    version = content.match(/Version\:\s(.*)/).captures.first
    desc_start = content.index("Description: ") + 13
    desc_end = content.index("License: ")
    description = content[desc_start...desc_end].squish

    Package.new(name, title, version, description)
  end
end
