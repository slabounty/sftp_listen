require "spec_helper"

module SftpListen
  describe Configuration do
    let(:config) { SftpListen::Configuration.new }

    describe "#initialize" do
      it "sets the default user_name" do
        expect(config.user_name).to eql("")
      end

      it "sets the default password" do
        expect(config.password).to eql("")
      end

      it "sets the default port" do
        expect(config.port).to eql(22)
      end

      it "sets the default directories" do
        expect(config.directories).to eql(["inbound", "outbound"])
      end

      it "sets the default handler klass" do
        expect(config.handler_klass).to eql(nil)
      end
    end
  end
end
