require "httparty"
require "lulu_api/version"
require "lulu_api/client"

module LuluApi
  class Error < StandardError; end

  class << self
    attr_writer :logger

    def logger
      @logger ||= defined?(Rails) ? Rails.logger : Logger.new(STDOUT)
    end
  end
end
