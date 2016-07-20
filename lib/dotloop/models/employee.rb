module Dotloop
  module Models
    class Employee
      include Virtus.model
      attribute :email_address
      attribute :first_name
      attribute :is_admin, Boolean
      attribute :last_name
      attribute :loops_created, Integer
      attribute :member_id, Integer
      attribute :status
      attribute :total_loops, Integer
    end
  end
end
