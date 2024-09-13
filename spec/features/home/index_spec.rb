require 'rails_helper'

RSpec.describe "Home Index Page", type: :feature do
  it "has a button to sign in with Google" do
    visit root_path

    expect(page).to have_button('Sign in with Google')
  end

  it "submits the Google sign-in form to the backend" do
    visit root_path

    click_button 'Sign in with Google'

    expect(page).to have_current_path("http://localhost:5000/api/v1/auth/google_oauth2", url: true)
  end
end
