require 'rails_helper'

describe "how user creates job" do
  it "creates job" do
    user = create(:user)
    visit "/"
    click_on "Log In as User"
    fill_in "Email", :with => "user@email.com"
    fill_in "Password", :with => "password"
    click_on "Log in"
    click_on "Add Your Job"
    fill_in "Title", :with => "Toliet"
    fill_in "Description", :with => "Running"
    click_on "Create Job"
    expect(page).to have_content("Toliet")
  end

  it "show errors for creating job when field is empty" do
    user = create(:user)
    visit "/"
    click_on "Log In as User"
    fill_in "Email", :with => "user@email.com"
    fill_in "Password", :with => "password"
    click_on "Log in"
    click_on "Add Your Job"
    click_on "Create Job"
    expect(page).to have_content('Job Not Created')
  end

end
