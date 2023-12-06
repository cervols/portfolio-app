require 'rails_helper'

RSpec.describe Skill, type: :model do
  subject { described_class.new(title: "Skill title", percent_utilized: 10)}

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end
end
