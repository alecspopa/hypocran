require 'rails_helper'

RSpec.describe CranPackageSaveJob, type: :job do
  setup do
    ActiveJob::Base.queue_adapter = :test
  end

  before do
    stub_request(:get, "https://cran.r-project.org/src/contrib/A3_1.0.0.tar.gz")
      .to_return(
        status: 200,
        body: package_content
      )
  end

  it "enqueues job" do
    expect {
      described_class.perform_later(0, "A3_1.0.0")
    }.to have_enqueued_job(described_class)
  end

  it "saves the package" do
    expect {
      described_class.perform_now(0, "A3_1.0.0")
    }.to change { Package.count }.by(1)
  end

  it "saves the package" do
    expect {
      described_class.perform_now(0, "A3_1.0.0")
    }.to change { PackageVersion.count }.by(1)
  end

  def package_content
    file_path = Rails.root.join("spec", "fixtures", "A3_1.0.0.tar.gz")
    File.open(file_path).read
  end
end
