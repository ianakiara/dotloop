module Dotloop
  class Client
    include HTTParty

    base_uri 'https://www.dotloop.com/my/api/v1_0/'

    attr_accessor :api_key
    attr_accessor :application

    def initialize(api_key:, application: 'dotloop')
      @api_key = api_key
      @application = application
      raise 'Please enter an API key' unless @api_key
    end

    def get(page, params = {})
      response = raw(page, params)
      self.class.snakify(response)
    end

    def raw(page, params = {})
      response = self.class.get(page, query: params, headers: headers, timeout: 60)
      raise "Error communicating: Response code #{response.code}" unless response.code == 200
      response.parsed_response
    end

    def Profile
      @profile ||= Dotloop::Profile.new(client: self)
    end

    def Loop
      @loop ||= Dotloop::Loop.new(client: self)
    end

    def Document
      @document ||= Dotloop::Document.new(client: self)
    end

    def self.snakify(hash)
      if hash.is_a? Array
        hash.map(&:to_snake_keys)
      else
        hash.to_snake_keys
      end
    end

    private

    def headers
      {
        'Authorization' => "Bearer #{@api_key}",
        'User-Agent' => @application,
        'Accept' => '*/*'
      }
    end
  end
end
