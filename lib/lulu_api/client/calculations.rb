module LuluApi
  class Client
    module Calculations

      def print_job_cost_calculations(body = {})
        fetch_token if @token.nil?

        response = self.class.post("/print-job-cost-calculations", { body: body.to_json })
        response.parsed_response["line_item_costs"]
      end

    end

  end
end
