module Dotloop
  class Client
    include HTTParty

    base_uri 'https://www.dotloop.com/my/api/v1_0/'

    attr_accessor :api_key

    def initialize(api_key:)
      @api_key = api_key
      raise 'Please enter an API key' unless @api_key
    end

    def get(page, params)
      response = self.class.get(page, params)
      raise 'Error communicating' unless response.code == 200
      self.class.snakify(response.parsed_result)
    end

    def Profile
      @profile ||= Dotloop::Profile.new(client: self)
    end

    def Loop
      @loop ||= Dotloop::Loop.new(client: self)
    end

    def self.snakify(hash)
      if hash.is_a? Array
        hash.map(&:to_snake_keys)
      else
        hash.to_snake_keys
      end
    end
  end
end
