module Dotloop
  module Models
    class Person
      include Virtus.model
      attribute :email
      attribute :first_name
      attribute :middle_name
      attribute :last_name
      attribute :person_id, Integer
      attr_accessor :client
    end
  end
end
