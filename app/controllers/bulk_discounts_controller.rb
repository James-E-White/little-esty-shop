class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.find(params[:id])
    #@bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.new(bulk_discount_params)
    if @bulk_discount.save
      redirect_to "/merchants/#{@merchant.id}/dashboard/bulk_discounts"

    else
      redirect_to "/merchants/#{@merchant.id}/dashboard/bulk_discounts/new"
      flash[:alert] = 'Please enter a valid discount'
    end
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find(params[:id])
    bulk_discount.destroy
    redirect_to "/merchants/#{@merchant.id}/bulk_discounts"
  end

  private

  def bulk_discount_params
    params.permit(:percent_discount, :quantity_threshold)
  end
end
