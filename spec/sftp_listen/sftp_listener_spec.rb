require "spec_helper"

module SftpListen
  describe SftpListener do
    describe "#start" do
      before do
        allow(subject).to receive(:sftp_server_start)
        allow(subject).to receive(:listener_start)
      end

      it "starts the SFTP server" do
        expect(subject).to receive(:sftp_server_start)
        subject.start
      end

      it "starts the Listener" do
        expect(subject).to receive(:listener_start)
        subject.start
      end
    end

    describe "#sftp_server_start" do
      let!(:sftp_server) { double('sftp_server').as_null_object }

      it "forks a process" do
        expect(subject).to receive(:fork) do |&block|
          expect(SFTPServer::Server).to receive(:new).and_return(sftp_server)
          block.call
        end

        subject.sftp_server_start
      end

      it "opens the server" do
        expect(sftp_server).to receive(:open)

        allow(subject).to receive(:fork) do |&block|
          allow(SFTPServer::Server).to receive(:new).and_return(sftp_server)
          block.call
        end

        subject.sftp_server_start
      end
    end

    describe "#listener_start" do
      let(:listener) { double('listener').as_null_object }

      before do
        allow(Listen).to receive(:to).and_return(listener)
        SftpListen.configure do |config|
          config.directories = ["my_inbound", "my_outbound"]
        end
      end

      it "creates a new listener" do
        expect(Listen).to receive(:to).with('my_inbound', 'my_outbound')
        subject.listener_start
      end

      it "starts the listener" do
        expect(listener).to receive(:start)
        subject.listener_start
      end
    end
  end
end
