require 'rails_helper'

RSpec.describe Package, type: :model do
  subject { create(:package, name: "package") }

  it "generates the package version link" do
    expect(subject.version_url("1.0")).to eq("package_1.0")
  end
end
