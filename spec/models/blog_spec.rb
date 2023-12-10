require 'rails_helper'

RSpec.describe Blog, type: :model do
  subject { described_class.new(title: "Post title", body: "Lorem ipsum")}

  it "is valid with valid attributes" do
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
