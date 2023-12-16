require "rails_helper"

RSpec.describe Blog, type: :model do
  subject { build(:blog) }

  it "has valid factory" do
    expect(subject).to be_valid
  end

  it "is not valid without title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without body" do
    subject.body = nil
    expect(subject).to_not be_valid
  end
end
