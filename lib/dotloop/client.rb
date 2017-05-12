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
      handle_dotloop_error(response.code) if response.code != 200
      response.parsed_response
    end

    def handle_dotloop_error(response_code)
      error = StandardError
      error = Dotloop::Errors::Client::Unauthorized if response_code == 401
      error = Dotloop::Errors::Client::Forbidden if response_code == 403
      raise error, "Error communicating: Response code #{response_code}"
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

    def Participant
      @participant ||= Dotloop::Participant.new(client: self)
    end

    def LoopActivity
      @loop_activity ||= Dotloop::LoopActivity.new(client: self)
    end

    def Task
      @task ||= Dotloop::Task.new(client: self)
    end

    def Folder
      @folder ||= Dotloop::Folder.new(client: self)
    end

    def Employee
      @employee ||= Dotloop::Employee.new(client: self)
    end

    def DocumentActivity
      @document_activity ||= Dotloop::DocumentActivity.new(client: self)
    end

    def Person
      @person ||= Dotloop::Person.new(client: self)
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
