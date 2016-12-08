module Dotloop
  module Models
    module Sections
      class ContractDates
        include Virtus.model
        attribute :contract_date
        attribute :closing_date
      end
    end
  end
end
