require 'rails_helper'

RSpec.describe 'Merchants bulk_discount show page' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Marvel', status: 'enabled')
    @merchant_2 = Merchant.create!(name: 'D.C.', status: 'disabled')
    @merchant_3 = Merchant.create!(name: 'Darkhorse', status: 'enabled')
    @merchant_4 = Merchant.create!(name: 'Image', status: 'disabled')
    @merchant_5 = Merchant.create!(name: 'Wonders', status: 'enabled')
    @merchant_6 = Merchant.create!(name: 'Disney', status: 'enabled')

    @discount_1 = BulkDiscount.create!(percent_discount: 15, quantity_threshold: 15, merchant_id: @merchant_1.id)
    @discount_2 = BulkDiscount.create!(percent_discount: 20, quantity_threshold: 20, merchant_id: @merchant_1.id)
    @discount_3 = BulkDiscount.create!(percent_discount: 10, quantity_threshold: 10, merchant_id: @merchant_2.id)
  end

  describe 'bulk_discount show' do
    it 'I see the percent_discount and quantity_threshold' do
    
      visit "/merchants/#{@merchant_1.id}/dashboard/bulk_discounts/#{@discount_1.id}"
      
      expect(page).to have_content("#{@discount_1.percent_discount}")
      expect(page).to have_content("#{@discount_1.quantity_threshold}")
      expect(page).to_not have_content("#{@discount_2.percent_discount}")
      expect(page).to_not have_content("#{@discount_2.quantity_threshold}")
    end
  end




end
