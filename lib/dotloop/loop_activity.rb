module Dotloop
  class LoopActivity
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all(profile_id:, loop_id:)
      @client.get("/profile/#{profile_id.to_i}/loop/#{loop_id.to_i}/activity").map do |loop_attrs|
        Dotloop::Models::LoopActivity.new(loop_attrs)
      end
    end
  end
end
