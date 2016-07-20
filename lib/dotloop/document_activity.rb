module Dotloop
  class DocumentActivity
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all(profile_id:, document_id:)
      @client.get("/profile/#{profile_id.to_i}/document/#{document_id.to_i}/activity").map do |document_attrs|
        Dotloop::Models::DocumentActivity.new(document_attrs)
      end
    end
  end
end
