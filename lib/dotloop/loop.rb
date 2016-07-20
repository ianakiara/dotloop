module Dotloop
  class Loop
    attr_accessor :client
    BATCH_SIZE = 50

    def initialize(client:)
      @client = client
    end

    def all(profile_id:, options: {})
      loops = []
      batch_number = 1
      loop do
        options[:batch_size] = BATCH_SIZE
        options[:batch_number] = batch_number
        current_loop = batch(profile_id: profile_id, options: options)
        loops += current_loop
        batch_number += 1
        break if current_loop.size < BATCH_SIZE
      end
      loops
    end

    def batch(profile_id:, options: {})
      @client.get("/profile/#{profile_id.to_i}/loop", query_params(options)).map do |attrs|
        Dotloop::Models::Loop.new(attrs)
      end
    end

    private

    def query_params(options)
      {
        batchNumber:         batch_number(options),
        batchSize:           batch_size(options),
        statusIds:           status_ids(options),
        complianceStatusIds: compliance_status_ids(options),
        tagIds:              tag_ids(options),
        sortBy:              options[:sort_by],
        searchQuery:         options[:search_query],
        tagNames:            options[:tag_names],
        createdByMe:         created_by_me(options)
      }.delete_if { |_, v| v.nil? }
    end

    def batch_number(options)
      zero_to_nil(options[:batch_number])
    end

    def batch_size(options)
      size = options[:batch_size].to_i
      return BATCH_SIZE if size < 1 || size > BATCH_SIZE
      size
    end

    def status_ids(options)
      options[:status_ids]&.map { |value| zero_to_nil(value) }
    end

    def compliance_status_ids(options)
      options[:compliance_status_ids]&.map { |value| zero_to_nil(value) }
    end

    def tag_ids(options)
      options[:tag_ids]&.map { |value| zero_to_nil(value) }
    end

    def created_by_me(options)
      zero_to_nil(options[:created_by_me])
    end

    def zero_to_nil(value)
      return if value.to_i < 1
      value.to_i
    end
  end
end
