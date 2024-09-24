require 'rails_helper'

RSpec.describe UserService do

  it "exists" do
    service = UserService.new

    expect(service).to be_an_instance_of UserService
  end

  it "#conn" do
    service = UserService.new
    connection = service.conn

    expect(connection).to be_an_instance_of Faraday::Connection
    expect(connection.url_prefix.to_s).to eq("https://https://pom-planner-be-31825074f3c8.herokuapp.com/")
  end

  it "#get_url" do
    # Stub the Faraday connection to return a mock response
    allow_any_instance_of(Faraday::Connection).to receive(:get)
    .with('test')
    .and_return(double(body: '{"message": "sldkjslfls"}'))

    service = UserService.new
    response = service.get_url('test')

    expect(response).to eq({ message: 'sldkjslfls' })
  end
end