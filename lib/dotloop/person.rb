module Dotloop
  class Person
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all(profile_id:)
      @client.get("/profile/#{profile_id.to_i}/person").map { |person_attrs| Dotloop::Models::Person.new(person_attrs) }
    end
  end
end
