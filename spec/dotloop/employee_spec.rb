require_relative '../spec_helper'

RSpec.describe Dotloop::Employee do
  let(:client) { Dotloop::Client.new(api_key: SecureRandom.uuid) }
  subject { Dotloop::Employee.new(client: client) }

  describe '#initialize' do
    it 'should exist' do
      expect(subject).to_not be_nil
    end

    it 'should set the client' do
      expect(subject.client).to eq(client)
    end
  end

  describe '#all' do
    it 'should return a list of employees' do
      dotloop_mock(:employees)
      employees = subject.all(profile_id: 1234)
      expect(employees).to_not be_empty
      expect(employees).to all(be_a(Dotloop::Models::Employee))
      expect(employees.first).to have_attributes(
        email_address: 'smurphy@emailaddress.com',
        first_name: 'Scott',
        is_admin: false,
        last_name: 'Murphy',
        status: 'ACTIVE',
        user_id: 294_132
      )
    end
  end
end
