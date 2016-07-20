module Dotloop
  class Task
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all(profile_id:, loop_id:)
      url = "/profile/#{profile_id.to_i}/loop/#{loop_id.to_i}/task"
      @client.get(url).map { |task_attrs| Dotloop::Models::Task.new(task_attrs) }
    end
  end
end
