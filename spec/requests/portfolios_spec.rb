require 'rails_helper'

RSpec.describe "Portfolios", type: :request do
  let(:valid_attributes) {{ title: "Post title", body: "post text" }}

  describe "GET /index" do
    it "renders a successful response" do
      Portfolio.create! valid_attributes
      get portfolios_url
      expect(response).to be_successful
    end
  end
end
