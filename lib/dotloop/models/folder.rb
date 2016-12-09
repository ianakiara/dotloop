module Dotloop
  module Models
    class Folder
      include Virtus.model
      attribute :folder_name
      attribute :folder_email
    end
  end
end
