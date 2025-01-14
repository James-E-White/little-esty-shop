class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
    @total_revenue = @invoice.all_revenue
    #@discounted_all_revenue = @invoice.discounted_all_revenue
  end

  def update
    invoice = Invoice.find(params[:id])
    invoice.update(invoice_params)
    redirect_to "/admin/invoices/#{invoice.id}"
  end

  private

  def invoice_params
    params.permit(:id, :status, :customer_id)
  end
end
