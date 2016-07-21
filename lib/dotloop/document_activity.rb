module Dotloop
  class DocumentActivity
    include Dotloop::QueryParamHelpers
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all(options = {})
      activities = []
      url = "/profile/#{profile_id(options)}/document/#{document_id(options)}/activity"
      (1..MAX_LOOPS).each do |i|
        options[:batch_number] = i
        current_activity = @client.get(url, query_params(options)).map do |act_attrs|
          Dotloop::Models::DocumentActivity.new(act_attrs)
        end
        activities += current_activity
        break if current_activity.size < BATCH_SIZE
      end
      activities
    end
  end
end
