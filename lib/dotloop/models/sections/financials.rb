module Dotloop
  module Models
    module Sections
      class Financials
        include Virtus.model

        attribute :comission_rate
        attribute :earnest_money_held_by
        attribute :purchase_price
        attribute :earnest_money_amount
        attribute :sale_commission_total
        attribute :buy_side_sale_commission_split
        attribute :sale_commission_split_sell_side
        attribute :sell_side_sale_commission_split
        attribute :sale_commission_split_buy_side
      end
    end
  end
end
