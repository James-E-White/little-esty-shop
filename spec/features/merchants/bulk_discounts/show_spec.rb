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
# As a merchant
# When I visit my bulk discount show page
# Then I see the bulk discount's quantity threshold and percentage discount
   describe 'bulk_discount show' do 
     it 'I see the percent_discount and quantity_threshold' do 
      visit "/merchants/#{@merchant_1.id}/bulk_discounts" 


      expect(page).to have_content("#{@discount_1.percent_discount}")
      expect(page).to have_content("#{@discount_1.quantity_threshold}")
      save_and_open_page
     end
   end
  
  
  
end