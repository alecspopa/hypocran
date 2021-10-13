require 'rails_helper'

RSpec.describe CranPackageParserService, type: :service do
  it "parses the sample content" do
    expect(described_class.parse(content)).to eq(expected_list_of_packages)
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

  def expected_list_of_packages
    [
      described_class::Package.new("A3", "1.0.0"),
      described_class::Package.new("aaSEA", "1.1.0"),
    ]
  end
end
