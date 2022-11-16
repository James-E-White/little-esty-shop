require 'rails_helper'

RSpec.describe 'Merchants bulk index page' do
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

    @customer1 = Customer.create!(first_name: 'Peter', last_name: 'Parker')
    @customer2 = Customer.create!(first_name: 'Clark', last_name: 'Kent')
    @customer3 = Customer.create!(first_name: 'Louis', last_name: 'Lane')
    @customer4 = Customer.create!(first_name: 'Lex', last_name: 'Luther')
    @customer5 = Customer.create!(first_name: 'Frank', last_name: 'Castle')
    @customer6 = Customer.create!(first_name: 'Matt', last_name: 'Murdock')
    @customer7 = Customer.create!(first_name: 'Bruce', last_name: 'Wayne')

    @invoice1 = Invoice.create!(status: 'completed', customer_id: @customer1.id, created_at: Time.parse('21.01.28')) # marvel
    @invoice2 = Invoice.create!(status: 'completed', customer_id: @customer2.id, created_at: Time.parse('22.08.22')) # marvel
    @invoice3 = Invoice.create!(status: 'completed', customer_id: @customer3.id, created_at: Time.parse('22.07.04')) # marvel
    @invoice4 = Invoice.create!(status: 'cancelled', customer_id: @customer4.id, created_at: Time.parse('21.09.14')) # marvel
    @invoice5 = Invoice.create!(status: 'completed', customer_id: @customer5.id, created_at: Time.parse('22.10.10')) # marvel
    @invoice6 = Invoice.create!(status: 'completed', customer_id: @customer6.id, created_at: Time.parse('22.10.15')) # marvel
    @invoice7 = Invoice.create!(status: 'completed', customer_id: @customer7.id, created_at: Time.parse('21.12.25')) # D.C.
    @invoice8 = Invoice.create!(status: 'completed', customer_id: @customer1.id, created_at: Time.parse('20.02.22')) # D.C.
    @invoice9 = Invoice.create!(status: 'completed', customer_id: @customer2.id, created_at: Time.parse('22.06.12')) # marvel
    @invoice10 = Invoice.create!(status: 'completed', customer_id: @customer2.id, created_at: Time.parse('22.03.14')) # marvel
    @invoice11 = Invoice.create!(status: 'completed', customer_id: @customer3.id, created_at: Time.parse('22.03.17')) # marvel

    @item1 = Item.create!(name: 'Beanie Babies', description: 'Investments', unit_price: 100,
                          merchant_id: @merchant_1.id)
    @item2 = Item.create!(name: 'Bat-A-Rangs', description: 'Weapons', unit_price: 500, merchant_id: @merchant_2.id)
    @item3 = Item.create!(name: 'Bat Mask', description: 'Identity Protection', unit_price: 800,
                          merchant_id: @merchant_2.id)
    @item4 = Item.create!(name: 'Leotard', description: 'Costume', unit_price: 1850, merchant_id: @merchant_3.id)
    @item5 = Item.create!(name: 'Cape', description: 'Fully Functional', unit_price: 900, merchant_id: @merchant_4.id)
    @item6 = Item.create!(name: 'Black Makeup', description: 'Gallon Sized', unit_price: 50,
                          merchant_id: @merchant_5.id)
    @item7 = Item.create!(name: 'Batmobile', description: 'Only one left in stock', unit_price: 1_000_000,
                          merchant_id: @merchant_5.id)
    @item8 = Item.create!(name: 'Night-Vision Goggles', description: 'Required for night activities',
                          unit_price: 15_000, merchant_id: @merchant_6.id)
    @item9 = Item.create!(name: 'Bat-Cave', description: 'Bats not included', unit_price: 10_000_000,
                          merchant_id: @merchant_6.id)

    InvoiceItem.create!(quantity: 5, unit_price: 500, status: 'packaged', item_id: @item1.id, invoice_id: @invoice1.id)
    InvoiceItem.create!(quantity: 1, unit_price: 100, status: 'shipped', item_id: @item1.id, invoice_id: @invoice2.id)
    InvoiceItem.create!(quantity: 6, unit_price: 600, status: 'pending', item_id: @item1.id, invoice_id: @invoice3.id)
    InvoiceItem.create!(quantity: 12, unit_price: 1200, status: 'packaged', item_id: @item1.id,
                        invoice_id: @invoice4.id)
    InvoiceItem.create!(quantity: 8, unit_price: 800, status: 'packaged', item_id: @item1.id, invoice_id: @invoice5.id)
    InvoiceItem.create!(quantity: 20, unit_price: 2000, status: 'packaged', item_id: @item1.id,
                        invoice_id: @invoice6.id)
    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item1.id, invoice_id: @invoice9.id)
    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item1.id,
                        invoice_id: @invoice10.id)
    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item1.id,
                        invoice_id: @invoice11.id)

    InvoiceItem.create!(quantity: 50, unit_price: 5000, status: 'shipped', item_id: @item2.id, invoice_id: @invoice7.id)
    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item2.id, invoice_id: @invoice8.id)

    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item3.id, invoice_id: @invoice7.id)
    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item3.id,
                        invoice_id: @invoice11.id)
    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item3.id,
                        invoice_id: @invoice11.id)

    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item4.id,
                        invoice_id: @invoice11.id)
    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item4.id, invoice_id: @invoice6.id)
    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item4.id, invoice_id: @invoice6.id)

    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item5.id,
                        invoice_id: @invoice11.id)

    InvoiceItem.create!(quantity: 30, unit_price: 1500, status: 'shipped', item_id: @item6.id, invoice_id: @invoice8.id)
    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item6.id, invoice_id: @invoice8.id)
    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item6.id, invoice_id: @invoice8.id)

    InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item7.id,
                        invoice_id: @invoice11.id)
    InvoiceItem.create!(quantity: 5, unit_price: 1500, status: 'shipped', item_id: @item7.id, invoice_id: @invoice11.id)

    InvoiceItem.create!(quantity: 10, unit_price: 100, status: 'shipped', item_id: @item8.id, invoice_id: @invoice11.id)
    InvoiceItem.create!(quantity: 15, unit_price: 100, status: 'shipped', item_id: @item8.id, invoice_id: @invoice11.id)

    InvoiceItem.create!(quantity: 11, unit_price: 1350, status: 'shipped', item_id: @item9.id,
                        invoice_id: @invoice11.id)
    InvoiceItem.create!(quantity: 4, unit_price: 1350, status: 'shipped', item_id: @item9.id, invoice_id: @invoice11.id)

    @transaction1 = Transaction.create!(credit_card_number: '4801647818676136', credit_card_expiration_date: nil,
                                        result: 'failed', invoice_id: @invoice1.id)
    @transaction2 = Transaction.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: nil,
                                        result: 'success', invoice_id: @invoice1.id)
    @transaction3 = Transaction.create!(credit_card_number: '4800749911485986', credit_card_expiration_date: nil,
                                        result: 'success', invoice_id: @invoice2.id)
    @transaction4 = Transaction.create!(credit_card_number: '4923661117104166', credit_card_expiration_date: nil,
                                        result: 'success', invoice_id: @invoice3.id)
    @transaction5 = Transaction.create!(credit_card_number: '4536896899874279', credit_card_expiration_date: nil,
                                        result: 'failed', invoice_id: @invoice4.id)
    @transaction6 = Transaction.create!(credit_card_number: '4536896899874280', credit_card_expiration_date: nil,
                                        result: 'failed', invoice_id: @invoice4.id)
    @transaction7 = Transaction.create!(credit_card_number: '4536896899874281', credit_card_expiration_date: nil,
                                        result: 'success', invoice_id: @invoice5.id)
    @transaction8 = Transaction.create!(credit_card_number: '4536896899874286', credit_card_expiration_date: nil,
                                        result: 'failed', invoice_id: @invoice6.id)
    @transaction9 = Transaction.create!(credit_card_number: '4636896899874290', credit_card_expiration_date: nil,
                                        result: 'success', invoice_id: @invoice6.id)
    @transaction10 = Transaction.create!(credit_card_number: '4636896899874291', credit_card_expiration_date: nil,
                                         result: 'success', invoice_id: @invoice7.id)
    @transaction11 = Transaction.create!(credit_card_number: '4636896899874298', credit_card_expiration_date: nil,
                                         result: 'success', invoice_id: @invoice8.id)
    @transaction12 = Transaction.create!(credit_card_number: '4636896899878732', credit_card_expiration_date: nil,
                                         result: 'success', invoice_id: @invoice9.id)
    @transaction13 = Transaction.create!(credit_card_number: '4636896899878732', credit_card_expiration_date: nil,
                                         result: 'success', invoice_id: @invoice10.id)
    @transaction14 = Transaction.create!(credit_card_number: '4636896899845752', credit_card_expiration_date: nil,
                                         result: 'success', invoice_id: @invoice11.id)
  end

  # 1: Merchant Bulk Discounts Index
  # As a merchant
  # When I visit my merchant dashboard
  # Then I see a link to view all my discounts
  # When I click this link
  # Then I am taken to my bulk discounts index page
  # Where I see all of my bulk discounts including their
  # percentage discount and quantity thresholds
  # And each bulk discount listed includes a link to its show page
  it 'Then I see a link to view all my discounts, When I click this link, Then I am taken to my bulk discounts index page' do
    visit "/merchants/#{@merchant_1.id}/dashboard"

    expect(page).to have_link("#{@merchant_1.name}'s Discounts")
    click_link "#{@merchant_1.name}'s Discounts"
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/dashboard/bulk_discounts")

    expect(page).to have_content("#{@merchant_1.name}'s Discounts")

    #save_and_open_page
  end

  it 'has a link to each discount show page' do
    visit "/merchants/#{@merchant_1.id}/dashboard/bulk_discounts"
    expect(page).to have_link("#{@discount_1.id}")
    expect(page).to have_link("#{@discount_2.id}")
    
  end

  it 'has a button to delete discount' do 
    visit "/merchants/#{@merchant_1.id}/dashboard/bulk_discounts"
    expect(page).to have_button("Delete Discount #")
    
    expect(page).to have_button("Delete Discount #: #{@discount_1.id}")
    expect(page).to have_button("Delete Discount #: #{@discount_2.id}")
    
    click_on "Delete Discount #: #{@discount_1.id}"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/dashboard/bulk_discounts")
    #save_and_open_page
  
    expect(page).to_not have_content("Percent_discount: #{@discount_1.percent_discount}")
    expect(page).to_not have_content("Quantity_threshold: #{@discount_1.quantity_threshold}")
    expect(page).to have_content("Percent_discount: #{@discount_2.percent_discount}")
    expect(page).to have_content("Quantity_threshold: #{@discount_2.quantity_threshold}")


  end
end