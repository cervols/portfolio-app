class PortfoliosController < ApplicationController
  before_action :set_portfolio_item, only: %i[show edit update destroy move]
  access all: %i[show index],
         user: { except: %i[new edit create update destroy move] },
         site_admin: :all
  layout "portfolio"

  def index
    @portfolio_items = Portfolio.by_position
  end

  def show; end

  def new
    @portfolio_item = Portfolio.new
  end

  def edit; end

  def create
    @portfolio_item = Portfolio.new(portfolio_params)

    respond_to do |format|
      if @portfolio_item.save
        format.html { redirect_to portfolio_show_url(@portfolio_item), notice: "Portfolio was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @portfolio_item.update(portfolio_params)
        format.html { redirect_to portfolio_show_url(@portfolio_item), notice: "Portfolio was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @portfolio_item.destroy

    respond_to do |format|
      format.html { redirect_to portfolios_url, notice: "Portfolio was successfully removed." }
    end
  end

  def move
    @portfolio_item.insert_at(params[:position].to_i)
    head :no_content
  end

  private

    def set_portfolio_item
      @portfolio_item = Portfolio.find(params[:id])
    end

    def portfolio_params
      params.require(:portfolio).permit(
        :title,
        :subtitle,
        :body,
        :main_image,
        :thumb_image,
        technologies_attributes: %i[id name _destroy]
      )
    end
end
