require_relative '../spec_helper'

RSpec.describe Dotloop::Person do
  let(:client) { Dotloop::Client.new(api_key: SecureRandom.uuid) }
  subject { Dotloop::Person.new(client: client) }

  describe '#initialize' do
    it 'should exist' do
      expect(subject).to_not be_nil
    end

    it 'should set the client' do
      expect(subject.client).to eq(client)
    end
  end

  describe '#all' do
    it 'should return a list of persons' do
      dotloop_mock(:persons)
      persons = subject.all(profile_id: 1234)
      expect(persons).to_not be_empty
      expect(persons).to all(be_a(Dotloop::Models::Person))
      expect(persons.first).to have_attributes(
        email: 'FirstLast@test.com',
        first_name: 'Test FirstName',
        last_name: 'Test LastName',
        person_id: 3_623_822
      )
    end
  end
end
