class MyListener
  def perform(modified, added, removed)
    puts "modified = #{modified}"
    puts "added = #{added}"
    puts "removed = #{removed}"
  end
end

SftpListen.configure do |config|
  config.handler_klass = MyListener
  config.directories = ["sftp_files/inbound", "sftp_files/outbound"]
  config.user_name = 'listen_test'
  config.password = 'listen_test'
  config.port = '2299'

  config.rsa_key = File.expand_path('../keys/rsa_key', __FILE__)
  fail "could not find rsa key file: #{config.rsa_key}" unless File.exist?(config.rsa_key)

  config.dsa_key = File.expand_path('../keys/dsa_key', __FILE__)
  fail "could not find dsa key file: #{config.dsa_key}" unless File.exist?(config.dsa_key)
end

sftp_listener = SftpListen::SftpListener.new
sftp_listener.start

