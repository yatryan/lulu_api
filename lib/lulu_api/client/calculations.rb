module LuluApi
  class Client
    module Calculations

      def print_job_cost_calculations(body = {})
        LuluApi.logger.debug 'Lulu: Requesting Print Job Estimates'

        make_api_call do
          self.class.post("/print-job-cost-calculations", { body: body.to_json })
        end
      end

    end

  end
end
