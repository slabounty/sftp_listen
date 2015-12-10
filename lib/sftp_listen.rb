require "listen"
require "sftp_server"
require "sftp_listen/version"
require "sftp_listen/configuration"
require "sftp_listen/sftp_listener"

module SftpListen
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
