module Dotloop
  module Models
    class Document
      include Virtus.model
      attribute :created_by, Integer
      attribute :created_date, DateTime
      attribute :document_id, Integer
      attribute :document_name
      attribute :folder_name
      attribute :last_modified_date, DateTime
      attribute :loop_id, Integer
      attribute :shared_with, Array[Integer]
      attribute :signature_verfication_link
      attr_accessor :client
    end
  end
end
