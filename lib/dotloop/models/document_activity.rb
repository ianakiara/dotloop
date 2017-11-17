module Dotloop
  module Models
    class DocumentActivity
      include Virtus.model
      attribute :activity_date, Time
      attribute :message
    end
  end
end
