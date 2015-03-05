require 'hipchat-api'

URL = 'https: //api.hipchat.com/v1/rooms/message'
FORMAT = 'format=json'
TOKEN = '289f94f268a7e7cbda333fce2ab405'
DEFAULTS = {
  color: 'yellow',
  notify: false,
  message_format: 'text'
}
TESTERS_ROOM = '1058061'

# MyHipChat puts messages into a hip chat room upon order
class MyHipChat
  attr_reader :client, :room

  def initialize(room = TESTERS_ROOM)
    @client = HipChat::API.new(TOKEN)
    @room = room
    @user = 'test-bot'
  end

  def send(message, format = {})
    format = DEFAULTS.merge(format)
    @client.rooms_message(@room, @user, message, format[:notify],\
                          format[:color], format[:message_format])
  end
end
