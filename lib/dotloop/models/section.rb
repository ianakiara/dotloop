module Dotloop
  module Models
    class Section
      include Virtus.model

      attribute :buying_brokerage, Dotloop::Models::BuyingBrokerage
      attribute :financials, Dotloop::Models::Financials
      attribute :listing_brokerage, Dotloop::Models::ListingBrokerage
      attribute :property_address, Dotloop::Models::PropertyAddress
    end
  end
end
