module Dotloop
  module Models
    class LoopActivity
      include Virtus.model
      attribute :activity_date, Time
      attribute :message
    end
  end
end
