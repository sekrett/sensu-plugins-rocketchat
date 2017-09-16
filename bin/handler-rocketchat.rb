#!/opt/sensu/embedded/bin/ruby

require 'sensu-handler'
require 'rocketchat'
require_relative '../lib/sensu-plugins-rocketchat/content_generator.rb'

class NotifyRocketchat < Sensu::Handler #:nodoc:
  def handle
    session = rocketchat_session
    session.chat.post_message(channel: settings['rocketchat']['channel'],
                              text: content)
    session.logout
  end

  private

  def rocketchat_session
    rocket_server = RocketChat::Server.new(settings['rocketchat']['api_url'])
    rocket_server.login(settings['rocketchat']['username'],
                        settings['rocketchat']['password'])
  end

  def content
    SensuPluginsRocketchat::ContentGenerator.new(@event).content
  end
end
