require 'spec_helper.rb'

feature "Creating, editing, and deleting a tag", js: true do
  scenario "CRUD a tag" do
    visit '/'
    click_on "New Tag…"

    fill_in "text", with: "Baked Brussel Sprouts"
    fill_in "hits", with: "20"

    click_on "Save"

    expect(page).to have_content("Baked Brussel Sprouts")
    expect(page).to have_content("20")

    click_on "Edit"

    fill_in "text", with: "Roasted Brussel Sprouts"
    fill_in "hits", with: "20"

    click_on "Save"

    expect(page).to have_content("Roasted Brussel Sprouts")
    expect(page).to have_content("20")

    visit "/"
    fill_in "keywords", with: "Roasted"
    click_on "Search"

    click_on "Roasted Brussel Sprouts"

    click_on "Delete"

    expect(Tag.find_by_name("Roasted Brussel Sprouts")).to be_nil

  end
end
