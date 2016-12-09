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
      folders = subject.all(profile_id: 1_234, loop_view_id: 76_046)
      expect(folders).to_not be_empty
      expect(folders).to all(be_a(Dotloop::Models::Folder))
      expect(folders.first).to have_attributes(
        folder_name: 'Legal',
        folder_email: 'not-real@upload.dotloop.com'
      )
    end
  end
end
