require 'spec_helper'

describe LuluApi::Client::Auth do

  let(:client) { LuluApi::Client.new("client_key", "client_secret", "auth_string") }
  let(:api_url) { "https://api.lulu.com" }

  before(:each) do
    stub_request(:post, "#{api_url}#{resource_path}").to_return(body: response)
  end

  subject { client.post(resource_path) }

  context "#fetch_token" do

    let(:resource_path) { "/auth/realms/glasstree/protocol/openid-connect/token" }
    let(:response) { '{"access_token":"access_token"}' }

    it "makes auth call" do
      client.fetch_token

      request = a_request(:post, "https://api.lulu.com/auth/realms/glasstree/protocol/openid-connect/token").with(
          body: "grant_type=client_credentials&client_key=client_key&client_secret=client_secret",
          headers:  {'Authorization' => 'auth_string', 'Content-Type' => 'application/x-www-form-urlencoded'})

      expect(request).to have_been_made
    end

    it 'saves token' do
      client.fetch_token

      expect(client.token).to eql('access_token')
    end

  end
end