module SftpListen
  class Configuration
    attr_accessor :user_name, :password, :port, :directories, :handler_klass
    attr_accessor :rsa_key, :dsa_key

    def initialize
      @rsa_key = nil
      @dsa_key = nil
      @user_name = ""
      @password = ""
      @port = 22
      @directories = ["inbound", "outbound"]
      @handler_klass = nil
    end
  end
end
