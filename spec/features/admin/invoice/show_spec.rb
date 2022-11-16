require 'rails_helper'

RSpec.describe 'admin/invoices/invoice.id' do
  before :each do
    @customer_1 = Customer.create!(first_name: 'Eli', last_name: 'Fuchsman')

    @merchant = Merchant.create!(name: 'Test')

    @item_1 = Item.create!(name: 'item1', description: 'desc1', unit_price: 10, merchant_id: @merchant.id)
    @item_2 = Item.create!(name: 'item2', description: 'desc2', unit_price: 12, merchant_id: @merchant.id)

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 1, created_at: Time.parse('22.10.12'))

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 1)
    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 11, unit_price: 12, status: 1)

    @transaction_1 = Transaction.create!(credit_card_number: '1', result: 0, invoice_id: @invoice_1.id)
    @transaction_2 = Transaction.create!(credit_card_number: '1', result: 0, invoice_id: @invoice_1.id)
  end
  describe 'invoice show, has invoice info, invoice items info, and total revenue' do
    it 'shows related information to a specific invoice' do
      visit "/admin/invoices/#{@invoice_1.id}"

      expect(page).to have_content("Id: #{@invoice_1.id}")
      expect(page).to have_content('Status: completed')
      expect(page).to have_content('Created at: Wednesday, October 12, 2022')
      expect(page).to have_content('Customer Name: Eli Fuchsman')
    end

    it 'shows all items on the invoice including item name, quantity, price, status' do
      visit "/admin/invoices/#{@invoice_1.id}"
      # within("#invoice_item-#{invoice}")
      expect(page).to have_content('Invoice Items:')
      expect(page).to have_content('Item Name: item1')
      expect(page).to have_content('Unit Price: 10')
      expect(page).to have_content('Quantity: 9')
      expect(page).to have_content('Status: packaged')

      expect(page).to have_content('Item Name: item2')
      expect(page).to have_content('Unit Price: 12')
      expect(page).to have_content('Quantity: 11')
      expect(page).to have_content('Status: packaged')
    end
    #   When I visit an admin invoice show page
    # Then I see the total revenue that will be generated from this invoice

    it 'can update invoice status from a select field' do
      visit "/admin/invoices/#{@invoice_1.id}"
      choose(:status, option: 'in progress')
      click_on 'Update Invoice Status'
      expect(page).to have_content('Status: in progress')
    end
  end

# As an admin
# When I visit an admin invoice show page
# Then I see the total revenue from this invoice (not including discounts)
# And I see the total discounted revenue from this invoice which includes bulk discounts in the calculation
 before :each do 
    @merchant_1 = Merchant.create!(name: 'Marvel', status: 'enabled')
    @merchant_2 = Merchant.create!(name: 'D.C.', status: 'disabled')
    
    @discount_1 = BulkDiscount.create!(percent_discount: 15, quantity_threshold: 5, merchant_id: @merchant_1.id)
    @discount_2 = BulkDiscount.create!(percent_discount: 20, quantity_threshold: 10, merchant_id: @merchant_1.id)
    @discount_3 = BulkDiscount.create!(percent_discount: 10, quantity_threshold: 2, merchant_id: @merchant_2.id)
    
    @customer1 = Customer.create!(first_name: 'Peter', last_name: 'Parker')
    @customer2 = Customer.create!(first_name: 'Clark', last_name: 'Kent') 
    
    @invoice1 = Invoice.create!(status: 'completed', customer_id: @customer1.id, created_at: Time.parse('21.01.28'))
    @invoice2 = Invoice.create!(status: 'completed', customer_id: @customer2.id, created_at: Time.parse('22.08.22'))
    
    @item1 = Item.create!(name: 'Beanie Babies', description: 'Investments', unit_price: 100, merchant_id: @merchant_1.id)
    @item2 = Item.create!(name: 'Bat-A-Rangs', description: 'Weapons', unit_price: 500, merchant_id: @merchant_2.id)
    
    @invoice_item_1 = InvoiceItem.create!(quantity: 5, unit_price: 500, status: 'packaged', item_id: @item1.id, invoice_id: @invoice1.id)
    @invoice_item_2 = InvoiceItem.create!(quantity: 1, unit_price: 100, status: 'shipped', item_id: @item1.id, invoice_id: @invoice2.id)
    
    @invoice_item_3 = InvoiceItem.create!(quantity: 50, unit_price: 5000, status: 'shipped', item_id: @item2.id, invoice_id: @invoice1.id)
    @invoice_item_4 = InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item2.id, invoice_id: @invoice2.id)
    
    @transaction1 = Transaction.create!(credit_card_number: '4801647818676136', credit_card_expiration_date: nil, result: 'failed', invoice_id: @invoice1.id)
    @transaction2 = Transaction.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice1.id)
    @transaction3 = Transaction.create!(credit_card_number: '4800749911485986', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice2.id)
 end
  #  describe 'as an admin I see the total revenue from invoice including discounts' do
  #   it 'shows the revenue on admin' do 
  #   visit "/admin/invoices/#{@invoice_1.id}"
    
  #   expect(page).to have_content("Total Invoice Revenue: #{@invoice_1.id}")
  #   expect(page).to have_content("Total Invoice Revenue with Discounts: 2125.0")
  #   save_and_open_page
  #  end
  # end
end
