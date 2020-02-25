module LuluApi
  class Client
    module Auth

      def fetch_token
        body = "grant_type=client_credentials&client_key=#{@client_key}&client_secret=#{@client_secret}"
        headers = {'Authorization' => @auth_string, 'Content-Type' => 'application/x-www-form-urlencoded' }
        response = self.class.post("/auth/realms/glasstree/protocol/openid-connect/token", { headers: headers, body: body })
        @token = response.parsed_response['access_token']

        self.class.headers 'Authorization' => "Bearer #{@token}"
      end

    end

  end
end
