module Dotloop
  class Loop
    attr_accessor :client
    BATCH_SIZE = 50
    MAX_LOOPS = 500

    def initialize(client:)
      @client = client
    end

    # rubocop:disable Metrics/ParameterLists
    def all(
      profile_id:, batch_number: nil, batch_size: nil, status_ids: [],
      compliance_status_ids: [], tag_ids: [], sort_by: nil, search_query: nil,
      tag_names: nil, created_by_me: nil
    )
      options = keyword_to_hash(__method__, binding)
      options[:batch_size] = BATCH_SIZE
      loops = []
      (1..MAX_LOOPS).each do |i|
        options[:batch_number] = i
        current_loop = batch(options)
        loops += current_loop
        break if current_loop.size < BATCH_SIZE
      end
      loops
    end

    def batch(
      profile_id:, batch_number: nil, batch_size: nil, status_ids: [],
      compliance_status_ids: [], tag_ids: [], sort_by: nil, search_query: nil,
      tag_names: nil, created_by_me: nil
    )
      options = keyword_to_hash(__method__, binding)
      @client.get("/profile/#{profile_id.to_i}/loop", query_params(options)).map do |attrs|
        Dotloop::Models::Loop.new(attrs)
      end
    end

    def find(profile_id:, loop_id:)
      loop_data = @client.get("/profile/#{profile_id.to_i}/loop/#{loop_id.to_i}").first
      loop_detail = @client.get("/profile/#{profile_id.to_i}/loop/#{loop_id.to_i}/detail")
      Dotloop::Models::Loop.new(loop_data.merge(loop_detail))
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
      empty_to_nil([options[:status_ids]].flatten.map { |value| zero_to_nil(value) }.compact)
    end

    def compliance_status_ids(options)
      empty_to_nil([options[:compliance_status_ids]].flatten.map { |value| zero_to_nil(value) }.compact)
    end

    def tag_ids(options)
      empty_to_nil([options[:tag_ids]].flatten.map { |value| zero_to_nil(value) }.compact)
    end

    def created_by_me(options)
      zero_to_nil(options[:created_by_me])
    end

    def zero_to_nil(value)
      return if value.to_i < 1
      value.to_i
    end

    def empty_to_nil(value)
      return if value.empty?
      value
    end

    def keyword_to_hash(method_name, bound)
      parameter_keys = method(method_name).parameters.map(&:last)
      parameter_keys.each_with_object({}) do |key, memo|
        val = bound.local_variable_get(key)
        next if val.nil? || val.is_a?(Array) && val.empty?
        memo[key] = val
      end
    end
  end
end
