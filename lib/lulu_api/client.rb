module LuluApi
  class Client

    def initialize(client_key = nil, client_secret = nil, auth_string = nil, sandbox = nil)
      @client_key = client_key || ENV["LULU_CLIENT_KEY"]
      @client_secret = client_secret || ENV["LULU_SECRET_KEY"]
      @auth_string = client_secret || ENV["LULU_AUTH_STRING"]
      @sandbox = sandbox || ENV["LULU_USE_SANDBOX"]

      @default_headers = {
          'Content-Type' => 'application/json',
          'Cache-Control' => 'no-cache'
      }
    end

    def base_url
      @sandbox ? 'https://api.lulu.com/' : 'https://api.sandbox.lulu.com/'
    end

    def fetch_token
      response = perform_request('auth/realms/glasstree/protocol/openid-connect/token','POST', {
          grant_type: 'client_credentials',
          client_key: @client_key,
          client_secret: @client_secret,
      }, { 'Authorization' => @auth_string })

      @token = response['access_token']
    end

    def refresh_token
      @token = nil
    end

    def perform_request(path, method, body = nil, headers = {})
      url = "#{base_url}#{path}"

      headers = @default_headers.merge(headers)

      headers['Authorization'] = "Bearer #{@token}" unless @token.nil?


      if method.upcase == 'GET'
        response = HTTParty.get(url, headers: headers)
      elsif method.upcase == 'POST'
        response = HTTParty.get(url, headers: headers, body: body)
      elsif method.upcase == 'PATCH'
        response = HTTParty.get(url, headers: headers, body: body)
      elsif method.upcase == 'PUT'
        response = HTTParty.get(url, headers: headers, body: body)
      elsif method.upcase == 'DELETE'
        response = HTTParty.get(url, headers: headers)
      end

      if response && response.code == 401
        # REFRESH TOKEN
      end

      puts response

      JSON.parse(response.body)
    end
  end
end