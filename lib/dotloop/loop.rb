module Dotloop
  class Loop
    include Dotloop::QueryParamHelpers
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all(options = {})
      loops = []
      options[:batch_size] = BATCH_SIZE
      (1..MAX_LOOPS).each do |i|
        options[:batch_number] = i
        current_batch = batch(options)
        loops += current_batch
        break if current_batch.size < options[:batch_size]
      end
      loops
    end

    def batch(options = {})
      @client.get("/profile/#{profile_id(options)}/loop", query_params(options)).map do |attrs|
        Dotloop::Models::Loop.new(attrs)
      end
    end

    def find(profile_id:, loop_view_id:)
      loop_data = @client.get("/profile/#{profile_id.to_i}/loop/#{loop_view_id.to_i}")
      Dotloop::Models::Loop.new(loop_data)
    end

    def detail(profile_id:, loop_view_id:)
      loop_detail = @client.get("/profile/#{profile_id.to_i}/loop/#{loop_view_id.to_i}/detail")
      loop_detail[:sections] = Dotloop::Section.call(loop_detail[:sections]) if loop_detail[:sections]
      Dotloop::Models::LoopDetail.new(loop_detail)
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
      }.delete_if { |_, v| should_delete(v) }
    end
  end
end
