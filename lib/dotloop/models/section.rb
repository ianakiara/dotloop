module Dotloop
  module Models
    class Section
      include Virtus.model
      attribute :contract_dates,         Dotloop::Models::Sections::ContractDates
      attribute :contract_info,          Dotloop::Models::Sections::ContractInfo
      attribute :financials,             Dotloop::Models::Sections::Financials
      attribute :geographic_description, Dotloop::Models::Sections::GeographicDescription
      attribute :listing_information,    Dotloop::Models::Sections::ListingInformation
      attribute :offer_dates,            Dotloop::Models::Sections::OfferDates
      attribute :property_address,       Dotloop::Models::Sections::PropertyAddress
      attribute :property,               Dotloop::Models::Sections::Property
      attribute :referral,               Dotloop::Models::Sections::Referral
      attribute :contacts,               Array[Dotloop::Models::Sections::Contact]
    end
  end
end
