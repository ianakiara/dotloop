module Dotloop
  module Models
    class PropertyAddress
      include Virtus.model

      attribute :city
      attribute :country
      attribute :mls_number
      attribute :postal_code
      attribute :property_address_country
      attribute :state_or_province
      attribute :street_name
      attribute :street_number
    end
  end
end
