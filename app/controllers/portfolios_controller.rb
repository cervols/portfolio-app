class PortfoliosController < ApplicationController
  before_action :set_portfolio_item, only: %i[ show edit update destroy ]
  layout "portfolio"

  def index
    @portfolio_items = Portfolio.all
  end

  def show
  end

  def new
    @portfolio_item = Portfolio.new
    # TODO: remove after implementing dynamically adding technologies via js
    3.times { @portfolio_item.technologies.build }
  end

  def edit
  end

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

  private

    def set_portfolio_item
      @portfolio_item = Portfolio.find(params[:id])
    end

    def portfolio_params
      params.require(:portfolio).permit(
        :title,
        :subtitle,
        :body,
        technologies_attributes: [:id, :name]
      )
    end
end
