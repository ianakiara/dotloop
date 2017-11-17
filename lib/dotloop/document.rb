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
        doc.profile_id = profile_id.to_i
        doc.loop_view_id = loop_view_id.to_i
        doc
      end
    end

    def get(profile_id:, loop_view_id:, document_id:, document_name:)
      document_name = CGI.escape(document_name.delete('/;'))
      sio = StringIO.new
      sio.set_encoding(Encoding::ASCII_8BIT)
      sio.write(
        @client.raw(
          "/profile/#{profile_id.to_i}/loop/#{loop_view_id.to_i}/document/#{document_id}/#{document_name}.pdf"
        )
      )
      sio.flush
      sio.close
      sio
    end
  end
end
