class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:discount_id])
    # @merchant = Merchant.find(params[:merchant_id])
    
    #@bulk_discount = @merchant.bulk_discounts.find(params[:id])
  end

  def new
    @bulk_discount = BulkDiscount.new
    @merchant = Merchant.find(params[:merchant_id])
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
    @bulk_discount = @merchant.bulk_discounts.find(params[:discount_id])
    @bulk_discount.destroy
    redirect_to "/merchants/#{@merchant.id}/dashboard/bulk_discounts"
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.find(params[:discount_id])
  end

    def update
     @merchant = Merchant.find(params[:merchant_id])
     #@bulk_discount = @merchant.bulk_discounts.find(params[:discount_id])
     @bulk_discount = BulkDiscount.find(params[:discount_id]) 
     if @bulk_discount.update(bulk_discount_params)
     redirect_to "/merchants/#{@merchant.id}/dashboard/bulk_discounts/#{@discount.id}"
     else  
      redirect_to "/merchants/#{@merchant.id}/dashboard/bulk_discounts/#{@discount.id}/edit"
      flash[:alert] = 'Please enter a valid discount # and quantity threshold #'
     end
    end

  private

  def bulk_discount_params
    params.permit(:percent_discount, :quantity_threshold)
  end
end
