require "rails_helper"

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

  describe ".by_position" do
    let!(:portfolio_1) { create(:portfolio, position: 2) }
    let!(:portfolio_2) { create(:portfolio, position: 1) }

    it "returns portfolio items ordered by position ASC" do
      expect(described_class.by_position).to eq([portfolio_2, portfolio_1])
    end
  end
end
