require 'spec_helper'

describe P8Pusher::Client do
  let(:dev_client) { P8Pusher::Client.development }
  let(:client) { P8Pusher::Client.production }

  context 'URI' do
    it 'should return valid development URI' do
      expect(dev_client.jwt_uri).to eq(P8Pusher::APPLE_DEVELOPMENT_JWT_URI)
    end

    it 'should return valid production URI' do
      expect(client.jwt_uri).to eq(P8Pusher::APPLE_PRODUCTION_JWT_URI)
    end
  end
end

