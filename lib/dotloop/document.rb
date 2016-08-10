module Dotloop
  class Document
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all(profile_id:, loop_view_id:)
      @client.get("/profile/#{profile_id.to_i}/loop/#{loop_view_id.to_i}/document").map do |document_attrs|
        doc = Dotloop::Models::Document.new(document_attrs)
        doc.client = client
        doc
      end
    end

    def get(profile_id:, loop_view_id:, document_id:, document_name:)
      document_name = CGI.escape(document_name.delete('/'))
      StringIO.new(
        @client.raw(
          "/profile/#{profile_id.to_i}/loop/#{loop_view_id.to_i}/document/#{document_id}/#{document_name}.pdf"
        )
      )
    end
  end
end
