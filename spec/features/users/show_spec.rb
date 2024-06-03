require 'rails_helper'

RSpec.describe "User Show Page" do
  before :each do
    visit user_path(id: 1)
  end

  it "renders the header with a logout link" do
    expect(page).to have_content("PomPlanner")
    expect(page).to have_link("Logout", href: logout_path, class: "btn btn-secondary")
  end
end