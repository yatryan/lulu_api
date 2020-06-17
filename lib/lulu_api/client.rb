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

    attr_accessor :token, :max_retries

    def initialize(client_key = nil, client_secret = nil, auth_string = nil)
      @client_key = client_key || ENV["LULU_CLIENT_KEY"]
      @client_secret = client_secret || ENV["LULU_SECRET_KEY"]
      @auth_string = auth_string || ENV["LULU_AUTH_STRING"]

      @sandbox = ENV["RAILS_ENV"] == 'development' ||  ENV["LULU_USE_SANDBOX"]
      self.class.base_uri @sandbox ? 'https://api.sandbox.lulu.com/' : 'https://api.lulu.com/'

      @max_retries = 1
    end

    def base_url
      self.class.base_uri
    end

    protected

    ##
    # Make API call to Lulu API. Handles if a 401 is retrieved.
    #
    # @param &block <Block> - Actual API Call
    #
    # @return response <Hash> - Response from Lulu
    #
    def make_api_call
      response = nil
      attempted_retries = 0
      is_successful = false

      while attempted_retries <= @max_retries && !is_successful
        LuluApi.logger.debug "Lulu: make_api_call: Attempt #{attempted_retries+1}"

        fetch_token if @token.nil?
        response = yield

        if response.code == 401
          # Old Token, refresh and we will try again
          @token = nil
        else
          # No 401, should be good!
          is_successful = true
        end

        # Bump Attempts
        attempted_retries = attempted_retries + 1
      end

      handle_lulu_response response
    end

    ##
    # Handle response from Lulu safely.
    #
    def handle_lulu_response(response)
      if !response.response.kind_of?(Net::HTTPSuccess)
        LuluApi.logger.error("Error: Code: #{response.code}\nResponse:\n#{response.body}")
        nil
      elsif response.body && response.body != ''
        response.parsed_response
      else
        LuluApi.logger.info("Error: Something went wrong, expected response not received.\n#{response.inspect}")
        nil
      end
    end
  end
end