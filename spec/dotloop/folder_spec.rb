require_relative '../spec_helper'

RSpec.describe Dotloop::Folder do
  let(:client) { Dotloop::Client.new(api_key: SecureRandom.uuid) }
  subject { Dotloop::Folder.new(client: client) }

  describe '#initialize' do
    it 'should exist' do
      expect(subject).to_not be_nil
    end

    it 'should set the client' do
      expect(subject.client).to eq(client)
    end
  end

  describe '#all' do
    it 'should return a list of folders' do
      dotloop_mock(:folders)
      folders = subject.all(profile_id: 1_234, loop_id: 76_046)
      expect(folders).to_not be_empty
      expect(folders).to all(be_a(Dotloop::Models::Folder))
      expect(folders.first).to have_attributes(
        archived: false,
        folder_email_name: '7f9e7d88c31e49ccbf38199689a7e0ea',
        folder_id: 314_074,
        last_updated_date_iso: DateTime.parse('2014-05-27T10:58:21-04:00'),
        minimized: false,
        name: 'Folder',
        view_id: 259_626
      )
    end
  end
end
