class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchants
  has_many :invoices, through: :merchants
  has_many :invoice_items, through: :invoices
  validates_presence_of :percent_discount, :quantity_threshold
end