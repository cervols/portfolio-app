require 'rails_helper'

RSpec.describe "/blogs", type: :request do
  let(:valid_attributes) {{ title: "Post title", body: "post text" }}
  let(:invalid_attributes) {{ title: nil }}

  describe "GET /index" do
    it "renders a successful response" do
      Blog.create! valid_attributes
      get blogs_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      blog = Blog.create! valid_attributes
      get blog_url(blog)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_blog_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      blog = Blog.create! valid_attributes
      get edit_blog_url(blog)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Blog" do
        expect {
          post blogs_url, params: { blog: valid_attributes }
        }.to change(Blog, :count).by(1)
      end

      it "redirects to the created blog" do
        post blogs_url, params: { blog: valid_attributes }
        expect(response).to redirect_to(blog_url(Blog.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Blog" do
        expect {
          post blogs_url, params: { blog: invalid_attributes }
        }.to change(Blog, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post blogs_url, params: { blog: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {{ title: 'new title' }}

      it "updates the requested blog" do
        blog = Blog.create! valid_attributes
        patch blog_url(blog), params: { blog: new_attributes }
        blog.reload
        expect(blog.title).to eq(new_attributes[:title])
      end

      it "redirects to the blog" do
        blog = Blog.create! valid_attributes
        patch blog_url(blog), params: { blog: new_attributes }
        blog.reload
        expect(response).to redirect_to(blog_url(blog))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        blog = Blog.create! valid_attributes
        patch blog_url(blog), params: { blog: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested blog" do
      blog = Blog.create! valid_attributes
      expect {
        delete blog_url(blog)
      }.to change(Blog, :count).by(-1)
    end

    it "redirects to the blogs list" do
      blog = Blog.create! valid_attributes
      delete blog_url(blog)
      expect(response).to redirect_to(blogs_url)
    end
  end
end
