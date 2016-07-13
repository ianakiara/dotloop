module Dotloop
  class Profile
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('profile').map do |profile_attrs|
        Dotloop::Models::Profile.new(profile_attrs)
      end
    end
  end
end
