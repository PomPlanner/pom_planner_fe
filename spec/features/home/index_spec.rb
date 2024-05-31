require 'rails_helper'

RSpec.describe "Home Index Page" do
  it "has a button to sign in with Google" do
    visit root_path

    expect(page).to have_button('Sign in with Google')
  end
end