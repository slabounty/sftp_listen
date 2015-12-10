require "spec_helper"

module SftpListen
  describe SftpListener do
    describe "#start" do
      it "starts the SFTP server" do
        expect(subject).to receive(:sftp_server_start)
        subject.start
      end

      it "starts the Listener" do
        expect(subject).to receive(:listener_start)
        subject.start
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
