require_relative '../spec_helper'

RSpec.describe Dotloop::Client do
  let(:api_key) { 'blah' }
  let(:application) { 'bloh' }
  subject { Dotloop::Client.new(api_key: api_key, application: application) }

  describe '#initialize' do
    it 'should take an api key' do
      expect(subject).to be_a(Dotloop::Client)
      expect(subject.api_key).to eq('blah')
    end

    context 'without application' do
      subject { Dotloop::Client.new(api_key: api_key) }

      it 'should default the application name to dotloop' do
        expect(subject.application).to eq('dotloop')
      end
    end

    it 'should take an application name' do
      expect(subject.application).to eq('bloh')
    end

    context 'without an api key' do
      let(:api_key) { nil }
      it 'the constuctor should whine' do
        expect { subject }.to raise_error RuntimeError
      end
    end
  end

  describe '#get' do
    let(:parsed_response) { { blahBlog: 42 } }
    let(:code) { 200 }
    let(:response) { double(code: code, parsed_response: parsed_response) }
    let(:headers) do
      {
        'Authorization' => "Bearer #{api_key}",
        'User-Agent' => application,
        'Accept' => '*/*'
      }
    end

    it 'should call HTTParty get with the correct params' do
      expect(subject.class).to receive(:get)
        .with('foo', query: { bar: 2 }, headers: headers, timeout: 60).and_return(response)
      subject.get('foo', bar: 2)
    end

    context 'when there is an error' do
      let(:code) { 234 }
      it 'should raise an error if the response code is not 200' do
        expect(subject.class).to receive(:get).with('foo', anything).and_return(response)
        expect { subject.get('foo') }.to raise_error StandardError
      end
    end

    context 'when there is a 401 error' do
      let(:code) { 401 }
      it 'should raise an Unauthorized error' do
        expect(subject.class).to receive(:get).with('foo', anything).and_return(response)
        expect { subject.get('foo') }.to raise_error Dotloop::Errors::Client::Unauthorized
      end
    end

    context 'when there is a 403 error' do
      let(:code) { 403 }
      it 'should raise an Forbidden error' do
        expect(subject.class).to receive(:get).with('foo', anything).and_return(response)
        expect { subject.get('foo') }.to raise_error Dotloop::Errors::Client::Forbidden
      end
    end

    context 'when the response is a single object' do
      it 'it should snake the camels' do
        expect(subject.class).to receive(:get).and_return(response)
        expect(subject.get('foo', bar: 15)).to eq(blah_blog: 42)
      end
    end

    context 'when the response is an array' do
      let(:parsed_response) do
        [
          { fooBar: 10 },
          { snakeFace: 22 }
        ]
      end
      it 'should snake all the camels' do
        expect(subject.class).to receive(:get).and_return(response)
        expect(subject.get('foo', bar: 15)).to eq(
          [
            { foo_bar: 10 },
            { snake_face: 22 }
          ]
        )
      end
    end
  end

  describe '#Profile' do
    it 'should return a Profile object' do
      expect(subject.Profile).to be_a(Dotloop::Profile)
    end
  end

  describe '#Loop' do
    it 'should return a Loop object' do
      expect(subject.Loop).to be_a(Dotloop::Loop)
    end
  end

  describe '#Document' do
    it 'should return a Document object' do
      expect(subject.Document).to be_a(Dotloop::Document)
    end
  end

  describe '#Participant' do
    it 'should return a Participant object' do
      expect(subject.Participant).to be_a(Dotloop::Participant)
    end
  end

  describe '#LoopActivity' do
    it 'should return a LoopActivity object' do
      expect(subject.LoopActivity).to be_a(Dotloop::LoopActivity)
    end
  end

  describe '#Task' do
    it 'should return a Task object' do
      expect(subject.Task).to be_a(Dotloop::Task)
    end
  end

  describe '#Folder' do
    it 'should return a Folder object' do
      expect(subject.Folder).to be_a(Dotloop::Folder)
    end
  end

  describe '#Employee' do
    it 'should return a Employee object' do
      expect(subject.Employee).to be_a(Dotloop::Employee)
    end
  end

  describe '#DocumentActivity' do
    it 'should return a DocumentActivity object' do
      expect(subject.DocumentActivity).to be_a(Dotloop::DocumentActivity)
    end
  end

  describe '#Person' do
    it 'should return a Person object' do
      expect(subject.Person).to be_a(Dotloop::Person)
    end
  end
end
