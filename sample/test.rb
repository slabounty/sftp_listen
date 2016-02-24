require 'rubygems'
require 'bundler'

Bundler.require

class MyListener
  def perform(modified, added, removed)
    puts "modified = #{modified}"
    puts "added = #{added}"
    puts "removed = #{removed}"
  end
end

SftpListen.config.handler_klass = MyListener
SftpListen.config.directories = ["sftp_files/inbound", "sftp_files/outbound"]
SftpListen.config.user_name = 'listen_test'
SftpListen.config.password = 'listen_test'
SftpListen.config.port = '2299'

SftpListen.config.rsa_key = File.expand_path('../keys/rsa_key', __FILE__)
fail "could not find rsa key file: #{config.rsa_key}" unless File.exist?(SftpListen.config.rsa_key)

SftpListen.config.dsa_key = File.expand_path('../keys/dsa_key', __FILE__)
fail "could not find dsa key file: #{config.dsa_key}" unless File.exist?(SftpListen.config.dsa_key)

sftp_listener = SftpListen.new
sftp_listener.start
