module PortfoliosHelper
  def portfolio_img(img, type)
    if img.url.present?
      img.url
    elsif type == "main"
      generate_image(width: 600, height: 400)
    elsif type == "thumb"
      generate_image(width: 350, height: 200)
    end
  end

  private

    def generate_image(width:, height:)
      "http://placehold.it/#{width}x#{height}"
    end
end
