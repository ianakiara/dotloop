module Dotloop
  module Models
    module Sections
      class ContractInfo
        include Virtus.model
        attribute :transaction_number
        attribute :type
        #attribute :class
      end
    end
  end
end
