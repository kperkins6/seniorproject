require 'rails_helper.rb'

feature "Looking up tags", js: true do
  before do
    Tag.create!(text: 'Baked Potato w/ Cheese')
    Tag.create!(text: 'Garlic Mashed Potatoes')
    Tag.create!(text: 'Potatoes Au Gratin')
    Tag.create!(text: 'Baked Brussel Sprouts')
  end

  scenario "finding tags" do
    visit '/'
    fill_in "keywords", with: "baked"
    click_on "Search"

    expect(page).to have_content("Baked Potato")
    expect(page).to have_content("Baked Brussel Sprouts")
  end
end
