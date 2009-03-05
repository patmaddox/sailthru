require File.join(File.dirname(__FILE__), 'spec_helper')

module Sailthru
  describe Mailer do
    it "should create a client" do
      Class.new(Sailthru::Mailer).client.should be_kind_of(Sailthru::TriggermailClient)
    end

    describe "sending an email" do
      before(:each) do
        @klass = Class.new(Sailthru::Mailer) do
          def invitation(email_address)
            recipients email_address
          end
        end
        @mock_client = mock('client')
        Sailthru::TriggermailClient.stub!(:new).and_return @mock_client
      end

      it "should create a client for each email sent" do
        c = stub("client", :null_object => true)
        Sailthru::TriggermailClient.should_receive(:new).twice.and_return c
        2.times { @klass.deliver_invitation('pat@example.com') }
      end

      it "should parse the template name" do
        @mock_client.should_receive(:send).with("invitation", anything, anything, anything)
        @klass.deliver_invitation('pat@example.com')
      end

      it "should get the recipients from the mailer" do
        @mock_client.should_receive(:send).with(anything, "pat@example.com", anything, anything)
        @klass.deliver_invitation('pat@example.com')
      end
    end
  end
end
