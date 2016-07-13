module Dotloop
  class Loop
    attr_accessor :client

    # attr_accessor :profile_id
    # attr_accessor :batch_number
    # attr_accessor :batch_size
    # attr_accessor :status_ids
    # attr_accessor :compliance_status_ids
    # attr_accessor :tag_ids
    # attr_accessor :sort_by
    # attr_accessor :search_query
    # attr_accessor :tag_names
    # attr_accessor :created_by_me

    def initialize(client:)
      @client = client
    end

    def all(profile_id:)
      @client.get("/profile/#{profile_id.to_i}/loop").map do |attrs|
        Dotloop::Models::Loop.new(attrs)
      end
    end
  end
end
