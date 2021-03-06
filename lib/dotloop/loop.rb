module Dotloop
  class Loop
    include Dotloop::QueryParamHelpers
    attr_accessor :client

    STATUS_MAP = {
      private_listing: 1,
      active_listing:  2,
      under_contract:  3,
      sold:            4,
      leased:          5,
      archived:        6,
      pre_listing:     7,
      pre_offer:       8
    }.freeze

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
        lp = Dotloop::Models::Loop.new(attrs)
        lp.client = client
        lp.profile_id = profile_id(options)
        lp
      end
    end

    def find(profile_id:, loop_view_id:)
      loop_data = @client.get("/profile/#{profile_id.to_i}/loop/#{loop_view_id.to_i}")
      lp = Dotloop::Models::Loop.new(loop_data)
      lp.client = client
      lp.profile_id = profile_id.to_i
      lp
    end

    def detail(profile_id:, loop_view_id:)
      loop_detail = @client.get("/profile/#{profile_id.to_i}/loop/#{loop_view_id.to_i}/detail")
      loop_detail[:sections] = Dotloop::Section.new(loop_detail[:sections]).sections if loop_detail[:sections]
      Dotloop::Models::LoopDetail.new(loop_detail)
    end

    def self.statuses
      STATUS_MAP.keys
    end

    def statuses
      self.class.statuses
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
