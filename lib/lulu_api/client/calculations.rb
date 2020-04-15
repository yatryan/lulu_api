module LuluApi
  class Client
    module Calculations

      def print_job_cost_calculations(body = {})
        LuluApi.logger.debug 'Requesting Print Job Calculation'
        fetch_token if @token.nil?

        response = self.class.post("/print-job-cost-calculations", { body: body.to_json })
        handle_lulu_response response
      end

    end

  end
end
