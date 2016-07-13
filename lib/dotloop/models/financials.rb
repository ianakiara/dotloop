module Dotloop
  module Models
    class Financials
      include Virtus.model

      attribute :comission_rate
      attribute :current_price
      attribute :earnest_money_held_by
      attribute :original_listing_price
      attribute :purchase_price
    end
  end
end
