module Dotloop
  module Models
    class Loop
      include Virtus.model
      attribute :created_by, Integer
      attribute :last_updated, Time
      attribute :loop_id, Integer
      attribute :loop_name
      attribute :loop_status
      attribute :loop_tags, Array
      attribute :loop_view_id, Integer
      attribute :transaction_type

      attr_accessor :client
      attr_accessor :profile_id

      def detail
        client.Loop.detail(profile_id: profile_id, loop_view_id: loop_view_id)
      end

      def activities
        client.LoopActivity.all(profile_id: profile_id, loop_view_id: loop_view_id)
      end

      def tasks
        client.Task.all(profile_id: profile_id, loop_view_id: loop_view_id)
      end

      def folders
        client.Folder.all(profile_id: profile_id, loop_view_id: loop_view_id)
      end

      def documents
        client.Document.all(profile_id: profile_id, loop_view_id: loop_view_id)
      end

      def participants
        client.Participant.all(profile_id: profile_id, loop_view_id: loop_view_id)
      end
    end
  end
end
