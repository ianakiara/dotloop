require_relative '../spec_helper'

RSpec.describe Dotloop::Loop do
  let(:client) { Dotloop::Client.new(api_key: SecureRandom.uuid) }
  subject { Dotloop::Loop.new(client: client) }

  describe '#initialize' do
    it 'should exist' do
      expect(subject).to_not be_nil
    end

    it 'should have a client' do
      expect(subject.client).to eq(client)
    end
  end

  before(:each) { dotloop_mock_batch(:loops) }
  describe '#all' do
    it 'should return all loops' do
      expect(subject).to receive(:batch).twice.and_call_original
      loops = subject.all(profile_id: '1234', batch_size: '20')
      expect(loops.size).to eq(52)
      expect(loops).to all(be_a(Dotloop::Models::Loop))
      expect(loops.first.attributes).to eq(
        Dotloop::Models::Loop.new(
          created_by: 2_097_622,
          last_updated: '2013-12-03T11:38:22-05:00',
          loop_id: 34_242,
          loop_name: 'Atturo Garay 123Main Street, Chicago, IL 60605',
          loop_status: 'Archived',
          loop_tags: [{
            profile_id: 4_533,
            tag_id: 2,
            tag_name: 'Buying'
          }],
          loop_view_id: 76_046,
          transaction_type: 'Listing for Sale'
        ).attributes
      )
    end

    it 'accepts additional parameters' do
      expect(client).to receive(:get).with(
        '/profile/1234/loop',
        batchNumber: 1,
        batchSize: 50,
        statusIds: [1, 2, 3],
        complianceStatusIds: [3, 4, 5],
        tagIds: [6, 7, 8],
        sortBy: 'sort me',
        searchQuery: 'search me',
        tagNames: 'tags',
        createdByMe: 123_456
      ).and_return([])
      subject.all(
        profile_id: '1234',
        statuses: %i(private_listing active_listing under_contract),
        compliance_status_ids: [3, 4, 5],
        tag_ids: [6, 7, 8],
        sort_by: 'sort me',
        search_query: 'search me',
        tag_names: 'tags',
        created_by_me: 123_456
      )
    end
  end

  describe '#find' do
    it 'finds a single loop by id' do
      dotloop_mock(:loop)
      loop_data = subject.find(profile_id: 1234, loop_view_id: 76_046)
      expect(loop_data).to be_a(Dotloop::Models::Loop)
      expect(loop_data).to have_attributes(
        created_by: 2_571_509,
        last_updated: DateTime.parse('2014-07-28T16:11:56-04:00'),
        loop_id: 274_231,
        loop_name: 'buyers',
        loop_status: 'Private',
        loop_tags: [0],
        loop_view_id: 76_046,
        transaction_type: 'Purchase'
      )
    end
  end

  describe '#detail' do
    it 'finds a single loop detail by id' do
      dotloop_mock(:loop_detail)
      loop_detail = subject.detail(profile_id: 1234, loop_view_id: 76_046)
      sections = loop_detail.sections
      expect(loop_detail).to be_a(Dotloop::Models::LoopDetail)
      expect(loop_detail.loop_id).to eq 274_231
      expect(sections).to be_a(Dotloop::Models::Section)
      expect(sections.contract_dates).to be_a(Dotloop::Models::Sections::ContractDates)
      expect(sections.contract_info).to be_a(Dotloop::Models::Sections::ContractInfo)
      expect(sections.financials).to be_a(Dotloop::Models::Sections::Financials)
      expect(sections.geographic_description).to be_a(Dotloop::Models::Sections::GeographicDescription)
      expect(sections.listing_information).to be_a(Dotloop::Models::Sections::ListingInformation)
      expect(sections.offer_dates).to be_a(Dotloop::Models::Sections::OfferDates)
      expect(sections.property).to be_a(Dotloop::Models::Sections::Property)
      expect(sections.property_address).to be_a(Dotloop::Models::Sections::PropertyAddress)
      expect(sections.referral).to be_a(Dotloop::Models::Sections::Referral)
      expect(sections.contacts).to all(be_a(Dotloop::Models::Sections::Contact))
    end

    it 'finds a single loop detail by id when the sections are empty' do
      dotloop_mock(:loop2_detail)
      loop_detail = subject.detail(profile_id: 1234, loop_view_id: 76_047)
      sections = loop_detail.sections
      expect(loop_detail).to be_a(Dotloop::Models::LoopDetail)
      expect(loop_detail.loop_id).to eq 274_232
      expect(sections).to be_nil
    end
  end

  describe '#statuses' do
    let(:status_list) { %i(private_listing active_listing under_contract sold leased archived pre_listing pre_offer) }
    it { expect(subject.statuses).to match_array(status_list) }
  end
end
