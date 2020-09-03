require 'spec_helper'

describe P8Pusher::Notification do
  FCM_TOKEN = 'SoMErANdomToKEn'.freeze
  TOPIC = 'some.random.topic'.freeze
  BADGE = 10
  CATEGORY = 'category'.freeze
  EXPIRY = 20
  TITLE = 'Title'.freeze
  SUBTITLE = 'Subtitle'.freeze
  BODY = 'This is body'.freeze
  SOUND = 'default'.freeze

  MESSAGE_STRING = '\x02\x00\x00\x00\x7F\x01\x00 \xC8n\xBA}\x86\xD8Np\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00R{\"aps\":{\"alert\":\"Hello World\",\"badge\":10,\"sound\":\"default\",\"category\":\"category\"}}\x04\x00\x04\x00\x00\x00\x14'.freeze

  let(:notification) {
    P8Pusher::Notification.new(device: FCM_TOKEN)
  }

  context 'Notification data' do
    before do
      notification.sound = SOUND
      notification.title = TITLE
      notification.subtitle = SUBTITLE
      notification.body = BODY
      notification.topic = TOPIC
      notification.badge = BADGE
      notification.category = CATEGORY
      notification.expiry = EXPIRY
    end

    it 'should include a valid notification data' do
      expect(notification.token).to eq(FCM_TOKEN)
      expect(notification.sound).to eq(SOUND)
      expect(notification.title).to eq(TITLE)
      expect(notification.subtitle).to eq(SUBTITLE)
      expect(notification.body).to eq(BODY)
      expect(notification.topic).to eq(TOPIC)
      expect(notification.badge).to eq(BADGE)
      expect(notification.category).to eq(CATEGORY)
      expect(notification.expiry).to eq(EXPIRY)

      expect(notification.valid?).to eq(true)
    end

    it 'should return a valid payload' do
      payload = notification.payload

      expect(payload.dig('aps', 'alert', 'title')).to eq(TITLE)
      expect(payload.dig('aps', 'alert', 'subtitle')).to eq(SUBTITLE)
      expect(payload.dig('aps', 'alert', 'body')).to eq(BODY)
      expect(payload.dig('aps', 'badge')).to eq(BADGE)
      expect(payload.dig('aps', 'category')).to eq(CATEGORY)
      expect(payload.dig('aps', 'sound')).to eq(SOUND)
    end

    it 'should return a valid message string' do
      expect(notification.message) == MESSAGE_STRING
    end

    it 'should not be marked as sent' do
      expect(notification.sent?).to eq(false)
    end

    it 'should mark the notification as sent' do
      expect(notification.sent?).to eq(false)
      notification.mark_as_sent!
      expect(notification.sent?).to eq(true)
    end

    it 'should should mark the notification as unsent' do
      expect(notification.sent?).to eq(false)
      notification.mark_as_sent!
      expect(notification.sent?).to eq(true)
      notification.mark_as_unsent!
      expect(notification.sent?).to eq(false)
    end
  end
end
