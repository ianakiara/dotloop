module Dotloop
  module Models
    class LoopActivity
      include Virtus.model
      attribute :activity_date, DateTime
      attribute :message
    end
  end
end
