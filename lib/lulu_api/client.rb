require 'json'
require "lulu_api/client/auth"
require "lulu_api/client/calculations"
require "lulu_api/client/print_jobs"

module LuluApi
  class Client
    include HTTParty
    include LuluApi::Client::Auth
    include LuluApi::Client::Calculations
    include LuluApi::Client::PrintJobs

    headers 'Content-Type' => 'application/json'
    headers 'Cache-Control' => 'no-cache'

    attr_accessor :token

    def initialize(client_key = nil, client_secret = nil, auth_string = nil)
      @client_key = client_key || ENV["LULU_CLIENT_KEY"]
      @client_secret = client_secret || ENV["LULU_SECRET_KEY"]
      @auth_string = auth_string || ENV["LULU_AUTH_STRING"]

      self.class.base_uri ENV["LULU_USE_SANDBOX"] ? 'https://api.sandbox.lulu.com/' : 'https://api.lulu.com/'
    end

    def base_url
      self.class.base_uri
    end
  end
end