require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it "has valid factory" do
    expect(subject).to be_valid
  end
end
