require "rails_helper"

RSpec.describe "/blogs", type: :request do
  let(:topic) { create(:topic) }
  let(:valid_attributes) { attributes_for(:blog, topic_id: topic.id) }
  let(:invalid_attributes) { { title: nil } }
  let(:user) { create(:user, :site_admin) }

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
    before { sign_in(user) }

    it "renders a successful response" do
      get new_blog_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    before { sign_in(user) }

    it "renders a successful response" do
      blog = Blog.create! valid_attributes
      get edit_blog_url(blog)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    before { sign_in(user) }

    context "with valid parameters" do
      it "creates a new Blog" do
        expect do
          post blogs_url, params: { blog: valid_attributes }
        end.to change(Blog, :count).by(1)
      end

      it "creates a blog with default status" do
        post blogs_url, params: { blog: valid_attributes }
        expect(Blog.last.status).to eq(Blog::DRAFT)
      end

      it "redirects to the created blog" do
        post blogs_url, params: { blog: valid_attributes }
        expect(response).to redirect_to(blog_url(Blog.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Blog" do
        expect do
          post blogs_url, params: { blog: invalid_attributes }
        end.to change(Blog, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post blogs_url, params: { blog: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    before { sign_in(user) }

    context "with valid parameters" do
      let(:new_attributes) { { title: 'new title' } }

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
    before { sign_in(user) }

    it "destroys the requested blog" do
      blog = Blog.create! valid_attributes
      expect do
        delete blog_url(blog)
      end.to change(Blog, :count).by(-1)
    end

    it "redirects to the blogs list" do
      blog = Blog.create! valid_attributes
      delete blog_url(blog)
      expect(response).to redirect_to(blogs_url)
    end
  end

  describe "PATCH /toggle_status" do
    before { sign_in(user) }

    it "redirects to the blogs list" do
      blog = Blog.create! valid_attributes
      patch toggle_status_blog_url(blog)
      expect(response).to redirect_to(blogs_url)
    end

    context "when blog was a draft" do
      it "changes status to published" do
        blog = Blog.create! valid_attributes
        expect do
          patch toggle_status_blog_url(blog)
        end.to change { blog.reload.status }.from(Blog::DRAFT).to(Blog::PUBLISHED)
      end
    end

    context "when blog was published" do
      it "changes status to draft" do
        blog = Blog.create! valid_attributes.merge(status: Blog::PUBLISHED)
        expect do
          patch toggle_status_blog_url(blog)
        end.to change { blog.reload.status }.from(Blog::PUBLISHED).to(Blog::DRAFT)
      end
    end
  end
end
