require "rails_helper"

RSpec.describe PortfoliosHelper, type: :helper do
  describe ".portfolio_img" do
    let(:portfolio) { create(:portfolio) }
    let(:image) { Rack::Test::UploadedFile.new(Rails.root.join("spec", "support", "files", "attachment.png")) }
    let(:main_placeholder) { "http://placehold.it/600x400" }
    let(:thumb_placeholder) { "http://placehold.it/350x200" }

    context "when the img param is 'main'" do
      subject(:image_url) { portfolio_img(portfolio.main_image, "main") }

      context "and image is uploaded" do
        let(:portfolio) { create(:portfolio, main_image: image) }

        it "returns correct url to image" do
          expect(image_url).to eq(portfolio.main_image.url)
        end
      end

      context "and image is not uploaded" do
        it "returns correct url to image" do
          expect(image_url).to eq(main_placeholder)
        end
      end
    end

    context "when the img param is 'thumb'" do
      subject(:image_url) { portfolio_img(portfolio.thumb_image, "thumb") }

      context "and image is uploaded" do
        let(:portfolio) { create(:portfolio, thumb_image: image) }

        it "returns correct url to image" do
          expect(image_url).to eq(portfolio.thumb_image.url)
        end
      end

      context "and image is not uploaded" do
        it "returns correct url to image" do
          expect(image_url).to eq(thumb_placeholder)
        end
      end
    end
  end
end
