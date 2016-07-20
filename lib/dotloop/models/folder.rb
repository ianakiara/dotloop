module Dotloop
  module Models
    class Folder
      include Virtus.model
      attribute :archived, Boolean
      attribute :folder_email_name
      attribute :folder_id, Integer
      attribute :last_updated_date_iso, DateTime
      attribute :minimized, Boolean
      attribute :name
      attribute :view_id, Integer
    end
  end
end
