require_relative '../spec_helper'

RSpec.describe Dotloop::Profile do
  let(:client) { double }
  subject { Dotloop::Profile.new(client: client) }

  describe '#initialize' do
    it 'should exist' do
      expect(subject).to_not be_nil
    end

    it 'should set the client' do
      expect(subject.client).to eq(client)
    end
  end

  describe '#all' do
    it 'should return a list of profiles' do
      expect(client).to receive(:get).with('/profile').and_return(json_fixture('profile.json'))
      profiles = subject.all
      expect(profiles).to_not be_empty
      expect(profiles).to all(be_a(Dotloop::Models::Profile))
      expect(profiles.first.client).to eq(client)
      expect(profiles.first).to have_attributes(
        active: true,
        address1: '123 Main St.',
        address2: '',
        city: 'Cincinnati',
        company_name: 'Demo Brokerage',
        deleted: false,
        fax_number: '',
        name: 'Demo Brokerage',
        phone_number: '5131234567',
        profile_id: 1234,
        profile_type: 'BROKERAGE',
        state: 'OH',
        suite: '',
        zipcode: '45203'
      )
    end
  end
end
