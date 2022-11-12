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
      visit "/merchants/#{@merchant_1.id}/bulk_discounts/#{@discount_1.id}"
      # save_and_open_page

      expect(page).to have_content("#{@discount_1.percent_discount}")
      expect(page).to have_content("#{@discount_1.quantity_threshold}")
      expect(page).to_not have_content("#{@discount_2.percent_discount}")
      expect(page).to_not have_content("#{@discount_2.quantity_threshold}")
      save_and_open_page
    end
  end
  # 5: Merchant Bulk Discount Edit
  # As a merchant
  # When I visit my bulk discount show page
  # Then I see a link to edit the bulk discount
  # When I click this link
  # Then I am taken to a new page with a form to edit the discount
  # And I see that the discounts current attributes are pre-poluated in the form
  # When I change any/all of the information and click submit
  # Then I am redirected to the bulk discount's show page
  # And I see that the discount's attributes have been updated
  describe 'adding an edit link to a bulk discount' do
    describe 'editing the discounts to show updated info' do
      it 'has a link to edit the discounts information' do
      visit "/merchants/#{@merchant_1.id}/bulk_discounts/#{@discount_1.id}"
       
      expect(page).

      end
    end
  end
end
