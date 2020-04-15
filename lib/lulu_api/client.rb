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

      @sandbox = ENV["RAILS_ENV"] == 'development' ||  ENV["LULU_USE_SANDBOX"]
      self.class.base_uri @sandbox ? 'https://api.sandbox.lulu.com/' : 'https://api.lulu.com/'
    end

    def base_url
      self.class.base_uri
    end

    protected

    def handle_lulu_response(response)
      puts response.response

      if !response.response.kind_of?(Net::HTTPSuccess)
        LuluApi.logger.error("Error: Code: #{response.code}\nResponse:\n#{response.body}")
        nil
      elsif response.body && response.body != ''
        response.parsed_response
      else
        LuluApi.logger.info('NOTHING')
        nil
      end

    end
  end
end