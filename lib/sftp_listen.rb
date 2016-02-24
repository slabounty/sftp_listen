require "listen"
require "sftp_server"
require "sftp_listen/version"
require 'active_support/configurable'

class SftpListen
  include ActiveSupport::Configurable
  attr_reader :server, :listener

  config.user_name = ''
  config.password = ''
  config.rsa_key = nil
  config.dsa_key = nil
  config.directories = %w(inbound outbound)
  config.handler_klass = nil

  class SftpListenerError < StandardError; end

  def start
    sftp_server_start
    listener_start
  end

  def sftp_server_start
    server_pid = fork do
      @server = SFTPServer::Server.new(
        rsa_key: config.rsa_key,
        dsa_key: config.dsa_key,
        user_name: config.user_name,
        password: config.password,
        port: config.port,
        listen_address: '0.0.0.0',
        verbose: true)
      @server.open
    end
  end

  def listener_start
    @listener = Listen.to(*config.directories) do |modified, added, removed|
      config.handler_klass.new.perform(modified, added, removed)
    end
    @listener.start
  end
end
