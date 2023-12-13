require 'rails_helper'

RSpec.describe Portfolio, type: :model do
  subject { build(:portfolio) }

  it "has valid factory" do
    expect(subject).to be_valid
  end

  it "is not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without body" do
    subject.body = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without main_image" do
    subject.main_image = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without thumb_image" do
    subject.thumb_image = nil
    expect(subject).to_not be_valid
  end
end
