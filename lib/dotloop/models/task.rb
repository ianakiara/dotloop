module Dotloop
  module Models
    class Task
      include Virtus.model
      attribute :completion_status
      attribute :created_by, Integer
      attribute :created_date, DateTime
      attribute :due_date, DateTime
      attribute :due_date_type, DateTime
      attribute :list_id, Integer
      attribute :list_name
      attribute :locked_status
      attribute :name
    end
  end
end
