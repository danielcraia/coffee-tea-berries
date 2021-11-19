# Main products
FactoryBot.create(:product, :coffee, price: 1123)
FactoryBot.create(:product, :green_tea, price: 311)
FactoryBot.create(:product, :strawberries, price: 500)

# Other products
FactoryBot.create_list(:product, 3)