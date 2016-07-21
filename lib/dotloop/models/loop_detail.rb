module Dotloop
  module Models
    class LoopDetail
      include Virtus.model
      attribute :loop_id, Integer
      attribute :sections, Dotloop::Models::Section
    end
  end
end
