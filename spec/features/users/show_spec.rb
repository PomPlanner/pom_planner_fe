require 'rails_helper'

RSpec.describe "User Show Page" do
  before :each do
    stub_request(:get, "http://localhost:5000/api/v1/users/1")
      .to_return(status: 200, body: {
        data: {
          id: "1",
          type: "user",
          attributes: {
            id: 1,
            name: "Test User",
            email: "test@example.com",
            image: "test_image.jpg"
          }
        }
      }.to_json)

    visit user_path(1)
  end
  
  it "renders the header with a logout link" do
    expect(page).to have_content("PomPlanner")
    expect(page).to have_link("Logout", href: logout_path, class: "btn btn-secondary")
  end
  
  it "has a section for user videos" do
    within '.favorite-videos' do
      expect(page).to have_content("Favorite Videos")
    end
  end
end