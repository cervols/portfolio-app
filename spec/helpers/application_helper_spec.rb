require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#alerts" do
    context "when flash message is empty" do
      it "returns nothing" do
        expect(helper.alerts).to be_nil
      end
    end

    context "when one flash message is present" do
      let(:message) { "message" }

      it "returns html with flash message" do
        helper.flash[:any_flash_type] = message
        expect(helper.alerts).to match(message)
      end

      context "when type of message is notice" do
        let(:class_name) { "text-bg-success" }

        before do
          helper.flash[:notice] = message
        end

        it "returns html with correct class name" do
          expect(helper.alerts).to match("text-bg-success")
        end
      end

      context "when type of message is alert" do
        let(:class_name) { "text-bg-success" }

        before do
          helper.flash[:alert] = message
        end

        it "returns html with correct class name" do
          expect(helper.alerts).to match("text-bg-danger")
        end
      end
    end

    context "when many flash messages with different types are present" do
      let(:alert_message) { "message" }
      let(:notice_message) { "message" }

      before do
        helper.flash[:alert] = alert_message
        helper.flash[:notice] = notice_message
      end

      it "returns html with all flash messages" do
        expect(helper.alerts).to match(alert_message).and match(notice_message)
      end
    end
  end
end
