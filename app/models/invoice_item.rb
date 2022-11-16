class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :merchants, through: :item
  has_many :bulk_discounts, through: :merchants

  validates_presence_of :quantity, :unit_price, :status, :item_id, :invoice_id

  enum status: { pending: 0, packaged: 1, shipped: 2 }

  def self.total_revenue(merchant)
    select(:quantity, :unit_price)
      .joins(:item)
      .where("merchant_id = #{merchant}")
      .sum("invoice_items.unit_price * quantity")
  end
     #moved into the invoice
#   def self.discount_list(merchant_id)
#     Discount.joins(:invoice_item)
#     binding.pry
#      .where('bulk_disounts.merchant_id = ?', merchant_id)
#     .where('invoice_items.quantity >= bulk_disounts.quantity_threshold')
#   end

#   def self.discount_list(merchant_id)
#       joins(:item, :bulk_discounts)
#       .where('items.merchant_id =? AND bulk_discounts.merchant_id =?', merchant_id, merchant_id)
#       .where('invoice_items.quantity >= bulk_discounts.quantity_threshold').where("bulk_discounts.quantity_threshold >= bulk_discounts.quantity_threshold")
#       .sum(' invoice_items.unit_price * percent_discount) * quantity')
     
#   end
end

