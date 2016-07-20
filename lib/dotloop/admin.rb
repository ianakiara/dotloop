module Dotloop
  class Admin
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all(profile_id:)
      @client.get("/profile/#{profile_id.to_i}/admin").map { |admin_attrs| Dotloop::Models::Admin.new(admin_attrs) }
    end
  end
end
