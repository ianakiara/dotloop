require_relative '../spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Dotloop::Task do
  let(:client) { Dotloop::Client.new(api_key: SecureRandom.uuid) }
  subject { Dotloop::Task.new(client: client) }

  describe '#initialize' do
    it 'should exist' do
      expect(subject).to_not be_nil
    end

    it 'should set the client' do
      expect(subject.client).to eq(client)
    end
  end

  describe '#all' do
    it 'should return a list of tasks' do
      dotloop_mock(:tasks)
      tasks = subject.all(profile_id: 1_234, loop_view_id: 76_046)
      expect(tasks).to_not be_empty
      expect(tasks).to all(be_a(Dotloop::Models::Task))
      expect(tasks.first).to have_attributes(
        completion_status: 'N',
        created_by: 3_104_719,
        created_date: DateTime.parse('2013-04-30T08:32:43-04:00'),
        due_date: DateTime.parse('2013-04-16T00:00:00-04:00'),
        due_date_type: DateTime.parse('2013-04-16T00:00:00-04:00'),
        list_id: 208,
        assigned_to_person: 9876,
        list_name: 'My Tasks',
        locked_status: 'N',
        name: 'Task New'
      )
    end
  end
end
