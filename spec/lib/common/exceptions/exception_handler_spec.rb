# frozen_string_literal: true

require 'rails_helper'
require 'common/exceptions/exception_handler'

RSpec.describe Common::Exceptions::ExceptionHandler do
  let(:user) { build(:user, :loa3) }
  let(:message) { 'the server responded with status 503' }
  let(:error_body) { { 'status' => 'some service unavailable status' } }
  let(:service) { 'Vet360' }

  describe '.initialize' do
    context 'when initialized without a nil error' do
      it 'raises an exception' do
        expect { described_class.new(nil, service) }.to raise_error(Common::Exceptions::ParameterMissing)
      end
    end
  end

  describe '#serialize_error' do
    context 'with a Common::Client::Errors::ClientError' do
      let(:error) { Common::Client::Errors::ClientError.new(message, 503, error_body) }
      let(:results) { described_class.new(error, service).serialize_error }

      it 'returns a serialized version of the error' do
        expect(results[:description]).to include message, error_body.to_s
      end

      it 'identifies the external service' do
        expect(results[:external_service]).to eq service
      end

      it 'sets the start_time' do
        expect(results[:start_time]).to be_present
      end

      it 'returns a status' do
        expect(results[:status]).to eq 503
      end
    end

    context 'with a Common::Exceptions::GatewayTimeout' do
      let(:error) { Common::Exceptions::GatewayTimeout.new }
      let(:results) { described_class.new(error, service).serialize_error }

      it 'returns a serialized version of the error' do
        expect(results[:description]).to include 'Gateway timeout', '504'
      end

      it 'returns a status' do
        expect(results[:status]).to eq 504
      end
    end

    def server_error_exception
      Common::Exceptions::BackendServiceException.new(
        'SCORECARD_503',
        { source: 'ScorecardApi::Client' },
        503,
        'some error body'
      )
    end

    context 'with a Common::Exceptions::BackendServiceException' do
      let(:error) { server_error_exception }
      let(:results) { described_class.new(error, service).serialize_error }

      it 'returns a serialized version of the error' do
        expect(results[:description]).to include 'SCORECARD_503', '503', 'Service unavailable'
      end

      it 'returns a status' do
        expect(results[:status]).to eq 503
      end
    end

    context 'with a StandardError' do
      let(:error) { StandardError.new(message) }
      let(:results) { described_class.new(error, service).serialize_error }

      it 'returns a serialized version of the error' do
        expect(results[:description]).to include message, 'StandardError'
      end

      it 'returns a status' do
        expect(results[:status]).to eq 503
      end
    end
  end
end