require "rails_helper"

RSpec.describe "Portfolios", type: :request do
  let(:invalid_attributes) {{ title: nil }}
  let(:user) { create(:user, :site_admin) }

  describe "GET /index" do
    it "renders a successful response" do
      create(:portfolio)
      get portfolios_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      portfolio = create(:portfolio)
      get portfolio_show_url(portfolio)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    before { sign_in(user) }

    it "renders a successful response" do
      get new_portfolio_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    before { sign_in(user) }

    it "renders a successful response" do
      portfolio = create(:portfolio)
      get edit_portfolio_url(portfolio)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    before { sign_in(user) }

    context "with valid parameters" do
      let(:valid_attributes) { attributes_for(:portfolio) }

      it "creates a new Portfolio" do
        expect {
          post portfolios_url, params: { portfolio: valid_attributes }
        }.to change(Portfolio, :count).by(1)
      end

      it "creates related technologies" do
        technologies_attrs = {
          technologies_attributes: [
            {
              name: "Rails"
            },
            {
              name: "Angular"
            }
          ]
        }

        expect {
          post portfolios_url, params: { portfolio: valid_attributes.merge(technologies_attrs) }
        }.to change(Technology, :count).by(2)
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
    before { sign_in(user) }

    context "with valid parameters" do
      let(:new_attributes) {{ title: 'new title' }}

      it "updates the requested portfolio" do
        portfolio = create(:portfolio)
        patch portfolio_url(portfolio), params: { portfolio: new_attributes }
        portfolio.reload
        expect(portfolio.title).to eq(new_attributes[:title])
      end

      it "updates the related technologies" do
        portfolio = create(:portfolio, :with_technology)
        new_technology_name = "Rails"
        technologies_attrs = {
          technologies_attributes: [
            {
              id: portfolio.technologies.first.id,
              name: new_technology_name
            }
          ]
        }

        expect {
          patch portfolio_url(portfolio), params: { portfolio: technologies_attrs }
        }.to change { portfolio.technologies.first.name }.to(new_technology_name)
      end

      it "redirects to the portfolio" do
        portfolio = create(:portfolio)
        patch portfolio_url(portfolio), params: { portfolio: new_attributes }
        portfolio.reload
        expect(response).to redirect_to(portfolio_show_url(portfolio))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        portfolio = create(:portfolio)
        patch portfolio_url(portfolio), params: { portfolio: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    before { sign_in(user) }

    it "destroys the requested portfolio" do
      portfolio = create(:portfolio)
      expect {
        delete portfolio_url(portfolio)
      }.to change(Portfolio, :count).by(-1)
    end

    it "redirects to the portfolios list" do
      portfolio = create(:portfolio)
      delete portfolio_url(portfolio)
      expect(response).to redirect_to(portfolios_url)
    end
  end
end
