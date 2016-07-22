module Dotloop
  class Document
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all(profile_id:, loop_id:)
      @client.get("/profile/#{profile_id.to_i}/loop/#{loop_id.to_i}/document").map do |document_attrs|
        doc = Dotloop::Models::Document.new(document_attrs)
        doc.client = client
        doc
      end
    end

    def get(profile_id:, loop_id:, document_id:, document_name:, output_path:)
      document_name = CGI.escape(document_name)
      output = StringIO.new(@client.raw("/profile/#{profile_id.to_i}/loop/#{loop_id.to_i}/document/#{document_id}/#{document_name}.pdf"))
      def output.original_filename
        [document_name, '.png'].join
      end
      output
    end
  end
end
