module Dotloop
  module Models
    module Sections
      class Referral
        include Virtus.model
        attribute :referral_source
        attribute :referral_percentage
      end
    end
  end
end
