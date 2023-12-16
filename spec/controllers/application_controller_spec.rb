require "rails_helper"

RSpec.describe ApplicationController, type: :request do
  describe "#set_source" do
    context "when there is 'q' parameter in url" do
      it "sets source" do
        get root_url, params: { q: "twitter" }
        expect(session[:source]).to eq("twitter")
      end

      it "does not change source after navigation to another page" do
        get root_url, params: { q: "twitter" }
        get new_user_session_url
        expect(session[:source]).to eq("twitter")
      end
    end

    context "when there is no 'q' parameter in url" do
      it "does not set source" do
        get root_url, params: {}
        expect(session[:source]).to be_nil
      end
    end
  end
end
