module Dotloop
  module Models
    class BuyingBrokerage
      include Virtus.model

      attribute :city
      attribute :name
      attribute :postal_code
      attribute :state_or_province
      attribute :street_name
      attribute :street_number
      attribute :suite
    end
  end
end
