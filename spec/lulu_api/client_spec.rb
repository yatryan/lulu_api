require 'spec_helper'

describe LuluApi::Client do

  context "initialize" do

    it 'defaults to production URL' do
      client = LuluApi::Client.new

      expect(client.base_url).to eql('https://api.lulu.com')
    end

    it 'uses sandbox URL when there ENV is provided' do
      ENV["LULU_USE_SANDBOX"] = "true"

      client = LuluApi::Client.new

      expect(client.base_url).to eql('https://api.sandbox.lulu.com')
    end

  end

end