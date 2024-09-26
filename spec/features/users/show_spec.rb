require 'rails_helper'

RSpec.describe "User Show Page" do
  before :each do
    # Mock the user login by setting the session
    allow_any_instance_of(ApplicationController).to receive(:session).and_return({ user_id: 1 })

    # Mock API response to return the user details
    stub_request(:get, "https://pom-planner-be-31825074f3c8.herokuapp.com/api/v1/users/1")
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
    expect(page).to have_button("Logout", class: "btn btn-danger")
  end
  
  it "has a section for user videos" do
    expect(page).to have_css('.favorite-title', text: 'Favorite Videos')
  end
end
