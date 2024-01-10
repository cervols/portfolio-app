require "rails_helper"

Rails.describe PortfoliosController, type: :controller do
  let(:user) { create(:user, :site_admin) }

  describe "PATCH /move" do
    subject { patch :move, params: { id: portfolio_2.id, position: 1 } }

    let!(:portfolio_1) { create(:portfolio) }
    let!(:portfolio_2) { create(:portfolio) }

    before { sign_in(user) }

    it "changes portfolio position" do
      subject
      expect(response).to have_http_status(:no_content)
    end

    it "changes portfolio position" do
      expect { subject }.to change { portfolio_1.reload.position }.from(1).to(2)
        .and change { portfolio_2.reload.position }.from(2).to(1)
    end
  end
end
