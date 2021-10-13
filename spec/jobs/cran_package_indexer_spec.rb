require 'rails_helper'

RSpec.describe CranPackageIndexerJob, type: :job do
  setup do
    ActiveJob::Base.queue_adapter = :test
  end

  before do
    stub_request(:get, "https://cran.r-project.org/src/contrib/PACKAGES")
      .to_return(
        status: 200,
        body: content
      )
  end

  it "enqueues job" do
    expect {
      described_class.perform_later(0)
    }.to have_enqueued_job(described_class)
  end

  it "calls list packages from the service" do
    expect {
      described_class.perform_now(0)
    }.to have_enqueued_job(CranPackageSaveJob)
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
    PACKAGE
  end

  def package
    CranPackageParserService::Package.new("A3", "1.0.0")
  end
end
