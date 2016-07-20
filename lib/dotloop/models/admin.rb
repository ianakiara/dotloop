module Dotloop
  module Models
    class Admin
      include Virtus.model
      attribute :email_address
      attribute :first_name
      attribute :is_admin, Boolean
      attribute :last_name
      attribute :member_id, Integer
      attribute :status
    end
  end
end
