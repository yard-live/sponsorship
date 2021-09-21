class SponsorshipsController < ApplicationController
  def index
    sponsorships = SponsorshipOrder.all
    render json: sponsorships
  end

  def show
  end

  def new
  end

  def create
    @sponsorship_order = SponsorshipOrder.new(sponsorship_order_params)
    if @sponsorship_order.save
      render json: @sponsorship_order
    else
      render json: @sponsorship_order.errors
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private 

  # Set up strong params
  def sponsorship_order_params
    params.require(:sponsorship_order).permit(:status, :paid_at, :stripe_id)
  end
end
