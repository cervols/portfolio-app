require 'rails_helper'

RSpec.describe "blogs/edit", type: :view do
  let(:blog) {
    Blog.create!(
      title: "MyString",
      body: "MyText"
    )
  }

  before(:each) do
    assign(:blog, blog)
  end

  it "renders the edit blog form" do
    render

    assert_select "form[action=?][method=?]", blog_path(blog), "post" do

      assert_select "input[name=?]", "blog[title]"

      assert_select "textarea[name=?]", "blog[body]"
    end
  end
end
