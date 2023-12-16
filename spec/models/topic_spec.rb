require "rails_helper"

RSpec.describe Topic, type: :model do
  subject { build(:topic) }

  it "has valid factory" do
    expect(subject).to be_valid
  end

  it "is not valid without title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end
end
