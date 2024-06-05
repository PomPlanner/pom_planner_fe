# require 'rails_helper'

# RSpec.describe PomPlannerService do

#   it "exists" do
#     service = PomPlannerService.new

#     expect(service).to be_an_instance_of PomPlannerService
#   end

#   it "#conn" do
#     service = PomPlannerService.new
#     connection = service.conn

#     expect(connection).to be_an_instance_of Faraday::Connection
#     expect(connection.url_prefix.to_s).to eq("http://localhost:5000/")
#   end

#   it "#get_url" do
#     # Stub the Faraday connection to return a mock response
#     allow_any_instance_of(Faraday::Connection).to receive(:get)
#     .with('test')
#     .and_return(double(body: '{"message": "sldkjslfls"}'))

#     service = PomPlannerService.new
#     response = service.get_url('test')

#     expect(response).to eq({ message: 'sldkjslfls' })
#   end
# end