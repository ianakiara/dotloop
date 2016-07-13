module Dotloop
  module Models
    class ListingBrokerage
      include Virtus.model

      attribute :city
      attribute :name
      attribute :office_phone
      attribute :postal_code
      attribute :state_or_province
      attribute :street_name
      attribute :street_number
    end
  end
end
