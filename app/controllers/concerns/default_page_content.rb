module DefaultPageContent
  extend ActiveSupport::Concern

  included do
    before_action :set_page_defaults
  end

  protected

    def set_page_defaults
      @page_title = "Portfolio App | Create your own blog"
      @seo_description = "Tetiana Zavediuk portfolio"
    end
end
