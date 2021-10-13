require 'rails_helper'

RSpec.describe CranService, type: :service do
  context "list packages" do
    before do
      stub_request(:get, "https://cran.r-project.org/src/contrib/PACKAGES")
        .to_return(
          status: 200,
          body: content
        )
    end

    it "returns a list of packages" do
      expect(described_class.list_packages).to eq(expected_list_of_packages)
    end
  end

  context "get package" do
    before do
      stub_request(:get, "https://cran.r-project.org/src/contrib/A3_1.0.0.tar.gz")
        .to_return(
          status: 200,
          body: package
        )
    end

    it "returns a package" do
      file = described_class.get_package(name_and_version: "A3_1.0.0")
      retrieved_package_hash = Digest::SHA256.hexdigest(file)
      expected_package_hash = Digest::SHA256.hexdigest(package)

      expect(retrieved_package_hash).to eq(expected_package_hash)
    end
  end

  def content
    return (<<~PACKAGE)
      Package: A3
      Version: 1.0.0
      Depends: R (>= 2.15.0), xtable, pbapply
      Suggests: randomForest, e1071
      License: GPL (>= 2)
      MD5sum: 027ebdd8affce8f0effaecfcd5f5ade2
      NeedsCompilation: no
      
      Package: aaSEA
      Version: 1.1.0
      Depends: R(>= 3.4.0)
      Imports: DT(>= 0.4), networkD3(>= 0.4), shiny(>= 1.0.5),
              shinydashboard(>= 0.7.0), magrittr(>= 1.5), Bios2cor(>= 2.0),
              seqinr(>= 3.4-5), plotly(>= 4.7.1), Hmisc(>= 4.1-1)
      Suggests: knitr, rmarkdown
      License: GPL-3
      MD5sum: 0f9aaefc1f1cf18b6167f85dab3180d8
      NeedsCompilation: no
    PACKAGE
  end

  def package
    file_path = Rails.root.join("spec", "fixtures", "A3_1.0.0.tar.gz")
    File.open(file_path).read
  end

  def expected_list_of_packages
    [
      CranPackageParserService::Package.new("A3", "1.0.0"),
      CranPackageParserService::Package.new("aaSEA", "1.1.0"),
    ]
  end
end
