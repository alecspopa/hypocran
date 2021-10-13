class CranPackageParserService
  Package = Struct.new(:name, :version)

  def self.parse(content)
    packages = content.split("\n\n")
    packages.map do |p|
      name = p.match(/Package\:\s(.*)/).captures.first
      version = p.match(/Version\:\s(.*)/).captures.first

      Package.new(name, version)
    end
  end
end
