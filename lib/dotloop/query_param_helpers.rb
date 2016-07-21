module Dotloop
  module QueryParamHelpers
    BATCH_SIZE = 50
    MAX_LOOPS = 500

    private

    def query_params(options)
      {
        batchNumber: batch_number(options),
        batchSize: batch_size(options)
      }.delete_if { |_, v| should_delete(v) }
    end

    def should_delete(value)
      value.nil? || (value.is_a?(Array) && value.empty?) || (value.is_a?(Integer) && value.zero?)
    end

    def profile_id(options)
      raise 'profile_id is required' unless options[:profile_id]
      options[:profile_id].to_i
    end

    def document_id(options)
      raise 'document_id is required' unless options[:document_id]
      options[:document_id].to_i
    end

    def batch_number(options)
      options[:batch_number].to_i
    end

    def loop_id(options)
      raise 'loop_id is required' unless options[:loop_id]
      options[:loop_id].to_i
    end

    def batch_size(options)
      size = options[:batch_size].to_i
      return BATCH_SIZE if size < 1 || size > BATCH_SIZE
      size
    end

    def status_ids(options)
      [options[:status_ids]].flatten.map(&:to_i).delete_if(&:zero?).compact
    end

    def compliance_status_ids(options)
      [options[:compliance_status_ids]].flatten.map(&:to_i).delete_if(&:zero?).compact
    end

    def tag_ids(options)
      [options[:tag_ids]].flatten.map(&:to_i).delete_if(&:zero?).compact
    end

    def created_by_me(options)
      options[:created_by_me].to_i
    end
  end
end
