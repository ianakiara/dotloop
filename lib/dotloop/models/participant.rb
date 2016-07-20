module Dotloop
  module Models
    class Participant
      include Virtus.model
      attribute :email
      attribute :member_of_my_team
      attribute :name, Boolean
      attribute :participant_id, Integer
      attribute :role
    end
  end
end
