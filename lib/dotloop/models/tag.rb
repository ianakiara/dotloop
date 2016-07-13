module Dotloop
  module Models
    class Tag
      include Virtus.model

      attribute :profile_id, Integer
      attribute :tag_id, Integer
      attribute :tag_name, String
    end
  end
end
