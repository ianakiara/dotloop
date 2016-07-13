module Dotloop
  module Models
    class Loop
      include Virtus.model

      attribute :created_by, Integer
      attribute :last_updated, DateTime
      attribute :loop_id, Integer
      attribute :loop_name
      attribute :loop_status
      attribute :loop_tags, Array
      attribute :loop_view_id, Integer
      attribute :transaction_type
      attribute :sections, Dotloop::Models::Section
    end
  end
end
