require 'rails_helper'

RSpec.describe Technology, type: :model do
  subject { build(:technology) }

  it "has valid factory" do
    expect(subject).to be_valid
  end
end
