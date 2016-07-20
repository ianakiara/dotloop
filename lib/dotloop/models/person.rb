module Dotloop
  module Models
    class Person
      include Virtus.model
      attribute :city
      attribute :email
      attribute :fax
      attribute :first_name
      attribute :homephone
      attribute :last_name
      attribute :officephone
      attribute :person_id, Integer
      attribute :state_or_prov
      attribute :street_address01
      attribute :zip_or_postal_code
      attr_accessor :client
    end
  end
end
