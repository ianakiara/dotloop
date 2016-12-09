module Dotloop
  module Models
    class Employee
      include Virtus.model
      attribute :email_address
      attribute :first_name
      attribute :is_admin, Boolean
      attribute :last_name
      attribute :status
      attribute :user_id, Integer
    end
  end
end
