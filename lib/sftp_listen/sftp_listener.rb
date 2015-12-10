module SftpListen
  class SftpListenerError < StandardError; end

  class SftpListener
    attr_reader :server, :listener

    def start
      sftp_server_start
      listener_start
    end

    def sftp_server_start
      puts "starting server #{Process.pid}"
      server_pid = fork do
        @server = SFTPServer::Server.new(
          rsa_key: SftpListen.configuration.rsa_key,
          dsa_key: SftpListen.configuration.dsa_key,
          user_name: SftpListen.configuration.user_name,
          password: SftpListen.configuration.password,
          port: SftpListen.configuration.port,
          listen_address: '0.0.0.0',
          verbose: true,
        )
        puts "opening server #{Process.pid}"
        @server.open
        puts "server open #{Process.pid}"
      end

      puts "server open #{Process.pid}"
    end

    def listener_start
      @listener = Listen.to(*SftpListen.configuration.directories) do |modified, added, removed|
        SftpListen.configuration.handler_klass.new.perform(modified, added, removed)
      end
      @listener.start
    end
  end
end
