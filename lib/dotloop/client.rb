module Dotloop
  class Client
    attr_accessor :api_key

    def initialize(api_key:)
      @api_key = api_key
      raise 'Please enter an API key' unless @api_key
    end
  end
end
