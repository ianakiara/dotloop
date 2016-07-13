require_relative '../spec_helper'

RSpec.describe Dotloop::Client do
  let(:api_key) { 'blah' }
  subject { Dotloop::Client.new(api_key: api_key) }

  it 'should take an api key' do
    expect(subject).to be_a(Dotloop::Client)
    expect(subject.api_key).to eq('blah')
  end

  context 'without an api key' do
    let(:api_key) { nil }
    it 'the constuctor should whine' do
      expect { subject }.to raise_error
    end
  end
end
