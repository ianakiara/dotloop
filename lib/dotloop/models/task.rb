module Dotloop
  module Models
    class Task
      include Virtus.model
      attribute :completion_status
      attribute :created_by, Integer
      attribute :created_date, Time
      attribute :due_date, Time
      attribute :due_date_type, Time
      attribute :list_id, Integer
      attribute :assigned_to_person, Integer
      attribute :list_name
      attribute :locked_status
      attribute :name
    end
  end
end
