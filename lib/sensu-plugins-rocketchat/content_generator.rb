require 'erubis'

module SensuPluginsRocketchat
  # Generates notification body from event data
  class ContentGenerator
    def initialize(event)
      @event = event
      @client = event['client']
      @check = event['check']
    end

    def content
      eruby = Erubis::Eruby.new(body)
      eruby.result(binding)
    end

    private

    def body
      <<-BODY.gsub(/^\s+/, '')
      <%= output %>
      Host: <%= @client['name'] %>
      Timestamp: <%= Time.at(@check['issued']) %>
      Address: <%= @client['address'] %>
      Check Name: <%= @check['name'] %>
      Command: <%= command %>
      Status: <%= status %>
      Occurrences: <%= @event['occurrences'] %>
      BODY
    end

    def command
      strip_passwords(@check['command'])
    end

    def output
      strip_passwords(@check['output'])
    end

    def strip_passwords(str)
      str.gsub(/(\s-p|\s-P|\s--password)(\s*\S+)/, '\1 [FILTERED]')
    end

    def status
      case @check['status']
      when 0
        'OK'
      when 1
        'WARNING'
      when 2
        'CRITICAL'
      else
        'UNKNOWN'
      end
    end
  end
end
