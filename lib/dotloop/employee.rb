module Dotloop
  class Employee
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all(profile_id:)
      @client.get("/profile/#{profile_id.to_i}/employee").map { |employee_attrs| Dotloop::Models::Employee.new(employee_attrs) }
    end
  end
end
