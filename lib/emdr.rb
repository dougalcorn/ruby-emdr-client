require 'celluloid/zmq'
require 'json'
require 'zlib'

class Emdr
  include Celluloid::ZMQ

  def initialize
    @subscriber = SubSocket.new
    @message_count = 0
    relays.each do |relay|
      subscriber.connect(relay)
    end
    subscriber.subscribe("")
  end

  def run
    @time_stamp = Time.now
    puts "Starting EMDR Client"
    async.output_message_rate
    loop { async.handle_message! next_message }
  end

  def next_message
    decode subscriber.read
  end

  def output_message_rate
    loop do
      sleep 15
      time_running = Time.now - @time_stamp
      rate = @message_count / time_running
      @message_count = 0
      @time_stamp = Time.now

      puts "Receiving #{rate} messages/sec"
    end

  end

  private

  attr_reader :subscriber

  def handle_message!(json)
    # This is a valid json message according to the
    # Unified Uploader Data Interchange Format
    # http://dev.eve-central.com/unifieduploader/start
    @message_count += 1
    # puts "Message from #{json['generator']['name']}/#{json['generator']['version']} of type #{json['resultType']} from #{json['currentTime']}"
  end

  def decode(data)
    #JSON.parse(Zlib::Inflate.new(Zlib::MAX_WBITS).inflate(data))
    data
  end

  def relays
    relays = []
    # relays.push('tcp://relay-us-west-1.eve-emdr.com:8050')
    # relays.push('tcp://relay-us-central-1.eve-emdr.com:8050')
    # relays.push('tcp://relay-ca-east-1.eve-emdr.com:8050')
    relays.push('tcp://relay-us-east-1.eve-emdr.com:8050')
    # relays.push('tcp://relay-eu-uk-1.eve-emdr.com:8050')
    # relays.push('tcp://relay-eu-france-2.eve-emdr.com:8050')
    # relays.push('tcp://relay-eu-germany-1.eve-emdr.com:8050')
    # relays.push('tcp://relay-eu-denmark-1.eve-emdr.com:8050')
    relays
  end
end
