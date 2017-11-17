module Dotloop
  module Models
    class Document
      include Virtus.model
      attribute :created_by, Integer
      attribute :created_date, Time
      attribute :document_id, Integer
      attribute :document_name
      attribute :folder_name
      attribute :last_modified_date, Time
      attribute :loop_id, Integer
      attribute :shared_with, Array[Integer]
      attribute :signature_verfication_link
      attribute :tags, Array
      attr_accessor :client
      attr_accessor :profile_id
      attr_accessor :loop_view_id

      def activities
        client.DocumentActivity.all(profile_id: profile_id, document_id: document_id)
      end

      def get
        client.Document.get(
          profile_id: profile_id,
          loop_view_id: loop_view_id,
          document_id: document_id,
          document_name: document_name
        )
      end
    end
  end
end
