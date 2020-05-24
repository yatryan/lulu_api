module LuluApi
  class Client
    module PrintJobs

      def list_print_jobs(options = {})
        LuluApi.logger.debug 'Lulu: Listing print jobs'

        make_api_call do
          self.class.get("/print-jobs", { query: options })
        end
      end

      def get_print_job(id)
        LuluApi.logger.debug 'Lulu: Getting print job'

        make_api_call do
          self.class.get("/print-jobs/#{id}")
        end
      end

      def get_print_job_costs(id)
        LuluApi.logger.debug 'Lulu: Getting print job cost'

        make_api_call do
          self.class.get("/print-jobs/#{id}/costs")
        end
      end

      def get_print_job_status(id)
        LuluApi.logger.debug 'Lulu: Getting print job status'
        make_api_call do
          self.class.get("/print-jobs/#{id}/status")
        end
      end

      def create_print_job(job)
        LuluApi.logger.debug 'Lulu: Creating print job'
        make_api_call do
          self.class.post("/print-jobs", { body: job.to_json })
        end
      end
    end
  end
end
