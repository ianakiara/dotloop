module Dotloop
  module Models
    module Sections
      class ListingInformation
        include Virtus.model
        attribute :property_excludes
        attribute :description_of_other_liens
        attribute :expiration_date
        attribute :listing_date
        attribute :total_encumbrances
        attribute :property_includes
        attribute :remarks
        attribute :current_price
        attribute :first_mortgage_balance
        attribute :homeowner_association
        attribute :second_mortgage_balance
        attribute :original_listing_price
        attribute :other_liens
        attribute :homeowner_association_dues
      end
    end
  end
end
