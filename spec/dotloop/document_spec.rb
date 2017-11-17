require_relative '../spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Dotloop::Document do
  let(:client) { Dotloop::Client.new(api_key: SecureRandom.uuid) }
  subject { Dotloop::Document.new(client: client) }

  describe '#initialize' do
    it 'should exist' do
      expect(subject).to_not be_nil
    end

    it 'should set the client' do
      expect(subject.client).to eq(client)
    end
  end

  describe '#all' do
    it 'should return a list of documents' do
      dotloop_mock(:documents)
      documents = subject.all(profile_id: 1_234, loop_view_id: 76_046)
      expect(documents).to_not be_empty
      expect(documents).to all(be_a(Dotloop::Models::Document))
      expect(documents.first).to have_attributes(
        created_by: 2_462,
        document_id: 561_622,
        document_name: 'AgencyDisclosureStatementSeller',
        folder_name: 'Folder',
        loop_id: 274_231,
        last_modified_date: Time.parse('2014-08-25T18:33:46-04:00'),
        created_date: Time.parse('2014-08-25T23:29:31-04:00'),
        shared_with: [405_246, 405_247, 405_260],
        tags: ['test tag'],
        signature_verfication_link: 'DL5616224301S'
      )
    end
  end

  describe '#get' do
    it 'removes forward slashes' do
      expect(client).to receive(:raw)
        .with('/profile/1234/loop/76046/document/561622/AgencyDisclosureStatementSeller.pdf')
        .and_return('foo')
      subject.get(profile_id: 1_234,
                  loop_view_id: 76_046,
                  document_id: 561_622,
                  document_name: 'AgencyDi/sclosureStatementSell/er')
    end

    it 'should get pdf data' do
      dotloop_pdf
      document = subject.get(profile_id: 1_234,
                             loop_view_id: 76_046,
                             document_id: 561_622,
                             document_name: 'AgencyDisclosureStatementSeller')
      expect(document.string).to eq(disclosure_file_data)
    end
  end
end
