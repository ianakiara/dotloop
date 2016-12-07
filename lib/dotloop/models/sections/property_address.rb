module Dotloop
  module Models
    module Sections
      class PropertyAddress
        include Virtus.model

        attribute :city
        attribute :county
        attribute :unit_number
        attribute :parcel_tax_id
        attribute :mls_number
        attribute :postal_code
        attribute :property_address_country
        attribute :state_or_province
        attribute :street_name
        attribute :street_number
      end
    end
  end
end
