require_relative '../../spec_helper'

RSpec.describe Dotloop::Models::Loop do
  let(:profile_id) { 1234 }
  let(:loop_view_id) { 76_046 }
  let(:detail_) { double }
  let(:activities_) { double }
  let(:tasks_) { double }
  let(:folders_) { double }
  let(:documents_) { double }
  let(:participants_) { double }

  let(:client) do
    double(
      Loop: detail_,
      LoopActivity: activities_,
      Task: tasks_,
      Folder: folders_,
      Document: documents_,
      Participant: participants_
    )
  end

  subject do
    lp = Dotloop::Models::Loop.new(loop_view_id: loop_view_id)
    lp.profile_id = profile_id
    lp.client = client
    lp
  end

  describe '#detail' do
    it 'should return the detail' do
      expect(detail_).to receive(:detail).with(profile_id: profile_id, loop_view_id: loop_view_id).and_return(:dets)
      expect(subject.detail).to eq(:dets)
    end
  end

  describe '#activies' do
    it 'should return activities' do
      expect(activities_).to receive(:all).with(profile_id: profile_id, loop_view_id: loop_view_id).and_return(:act)
      expect(subject.activities).to eq(:act)
    end
  end

  describe '#tasks' do
    it 'should return tasks' do
      expect(tasks_).to receive(:all).with(profile_id: profile_id, loop_view_id: loop_view_id).and_return(:act)
      expect(subject.tasks).to eq(:act)
    end
  end

  describe '#folders' do
    it 'should return folders' do
      expect(folders_).to receive(:all).with(profile_id: profile_id, loop_view_id: loop_view_id).and_return(:act)
      expect(subject.folders).to eq(:act)
    end
  end

  describe '#documents' do
    it 'should return documents' do
      expect(documents_).to receive(:all).with(profile_id: profile_id, loop_view_id: loop_view_id).and_return(:act)
      expect(subject.documents).to eq(:act)
    end
  end

  describe '#participants' do
    it 'should return participants' do
      expect(participants_).to receive(:all).with(profile_id: profile_id, loop_view_id: loop_view_id).and_return(:act)
      expect(subject.participants).to eq(:act)
    end
  end
end
