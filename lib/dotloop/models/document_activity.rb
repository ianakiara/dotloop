module Dotloop
  module Models
    class DocumentActivity
      include Virtus.model
      attribute :activity_date, DateTime
      attribute :message
    end
  end
end
