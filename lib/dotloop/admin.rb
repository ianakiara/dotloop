module Dotloop
  class Admin
    include Dotloop::QueryParamHelpers
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all(options = {})
      admins = []
      url = "/profile/#{profile_id(options)}/admin"
      (1..MAX_LOOPS).each do |i|
        options[:batch_number] = i
        current_admin = @client.get(url, query_params(options)).map do |admin_attrs|
          Dotloop::Models::Admin.new(admin_attrs)
        end
        admins += current_admin
        break if current_admin.size < BATCH_SIZE
      end
      admins
    end
  end
end
