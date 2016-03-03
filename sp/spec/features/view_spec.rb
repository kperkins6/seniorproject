require 'spec_helper.rb'

feature "Viewing a tag", js: true do
  before do
    Tag.create!(text: 'Baked Potato w/ Cheese', 
           hits: "20")

    Tag.create!(text: 'Baked Brussel Sprouts',
           hits: "5")
  end
  scenario "view one tag" do
    visit '/'
    fill_in "keywords", with: "baked"
    click_on "Search"

    click_on "Baked Brussel Sprouts"

    expect(page).to have_content("Baked Brussel Sprouts")
    expect(page).to have_content("5")

    click_on "Back"

    expect(page).to     have_content("Baked Brussel Sprouts")
    expect(page).to_not have_content("5")
  end
end
