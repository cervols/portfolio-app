require "rails_helper"

RSpec.describe ApplicationController do
  describe "#current_user" do
    context "when user is signed in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it "sets current_user as an instance of User" do
        expect(controller.current_user).to be_a(User)
      end
    end

    context "when user is not signed in" do
      it "sets current_user as an instance of OpenStruct" do
        expect(controller.current_user).to be_a(OpenStruct)
      end
    end
  end
end
