module Dotloop
  class Loop
    attr_accessor :client
    BATCH_SIZE = 50
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
      batches = []
      batch_number = 1
      loop do
        batch = retrieve_batch(profile_id: profile_id, batch_size: BATCH_SIZE, batch_number: batch_number)
        batches += batch
        batch_number += 1
        break if batch.size < BATCH_SIZE
      end
      batches
    end

    private

    def retrieve_batch(profile_id:, batch_size:, batch_number:)
      @client.get("/profile/#{profile_id.to_i}/loop", batchSize: batch_size, batchNumber: batch_number).map do |attrs|
        Dotloop::Models::Loop.new(attrs)
      end
    end
  end
end
