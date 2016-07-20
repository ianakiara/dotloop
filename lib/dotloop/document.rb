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
  end
end
