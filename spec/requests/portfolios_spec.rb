require 'rails_helper'

RSpec.describe "Portfolios", type: :request do
  let(:valid_attributes) { attributes_for(:portfolio) }
  let(:invalid_attributes) {{ title: nil }}

  describe "GET /index" do
    before do
      allow_any_instance_of(ActionView::Base).to receive(:image_tag)
    end

    it "renders a successful response" do
      Portfolio.create! valid_attributes
      get portfolios_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    before do
      allow_any_instance_of(ActionView::Base).to receive(:image_tag)
    end

    it "renders a successful response" do
      portfolio = Portfolio.create! valid_attributes
      get portfolio_show_url(portfolio)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_portfolio_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      portfolio = Portfolio.create! valid_attributes
      get edit_portfolio_url(portfolio)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Portfolio" do
        expect {
          post portfolios_url, params: { portfolio: valid_attributes }
        }.to change(Portfolio, :count).by(1)
      end

      it "redirects to the created portfolio" do
        post portfolios_url, params: { portfolio: valid_attributes }
        expect(response).to redirect_to(portfolio_show_url(Portfolio.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Portfolio" do
        expect {
          post portfolios_url, params: { portfolio: invalid_attributes }
        }.to change(Portfolio, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post portfolios_url, params: { portfolio: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {{ title: 'new title' }}

      it "updates the requested portfolio" do
        portfolio = Portfolio.create! valid_attributes
        patch portfolio_url(portfolio), params: { portfolio: new_attributes }
        portfolio.reload
        expect(portfolio.title).to eq(new_attributes[:title])
      end

      it "redirects to the portfolio" do
        portfolio = Portfolio.create! valid_attributes
        patch portfolio_url(portfolio), params: { portfolio: new_attributes }
        portfolio.reload
        expect(response).to redirect_to(portfolio_show_url(portfolio))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        portfolio = Portfolio.create! valid_attributes
        patch portfolio_url(portfolio), params: { portfolio: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested portfolio" do
      portfolio = Portfolio.create! valid_attributes
      expect {
        delete portfolio_url(portfolio)
      }.to change(Portfolio, :count).by(-1)
    end

    it "redirects to the portfolios list" do
      portfolio = Portfolio.create! valid_attributes
      delete portfolio_url(portfolio)
      expect(response).to redirect_to(portfolios_url)
    end
  end
end

