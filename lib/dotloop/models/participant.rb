module Dotloop
  module Models
    class Participant
      include Virtus.model
      attribute :email
      attribute :member_of_my_team, Boolean
      attribute :name
      attribute :participant_id, Integer
      attribute :role
    end
  end
end
