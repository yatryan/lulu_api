module LuluApi
  class Client
    module PrintJobs

      def list_print_jobs(options = {})
        fetch_token if @token.nil?

        response = self.class.get("/print-jobs", { query: options })
        handle_lulu_response response
      end

      def get_print_job(id)
        fetch_token if @token.nil?

        response = self.class.get("/print-jobs/#{id}")
        handle_lulu_response response
      end

      def get_print_job_costs(id)
        fetch_token if @token.nil?

        response = self.class.get("/print-jobs/#{id}/costs")
        handle_lulu_response response
      end

      def get_print_job_status(id)
        fetch_token if @token.nil?

        response = self.class.get("/print-jobs/#{id}/status")
        handle_lulu_response response
      end

      def create_print_job(job)
        fetch_token if @token.nil?

        response = self.class.post("/print-jobs", { body: job.to_json })
      end
    end
  end
end
