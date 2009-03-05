require File.join(File.dirname(__FILE__), 'spec_helper')


describe Sailthru::Mailer do
  it "should create a client" do
    Class.new(Sailthru::Mailer).client.should be_kind_of(Sailthru::TriggermailClient)
  end

  describe "sending an email" do
    before(:each) do
      @mock_client = mock('client')
      Sailthru::TriggermailClient.stub!(:new).and_return @mock_client
    end

    it "should create a client for each email sent" do
      c = stub("client", :null_object => true)
      Sailthru::TriggermailClient.should_receive(:new).twice.and_return c
      2.times { MyMailer.deliver_invitation('pat@example.com') }
    end

    it "should parse the template name" do
      @mock_client.should_receive(:send).with("invitation", anything, anything, anything)
      MyMailer.deliver_invitation('pat@example.com')
    end

    it "should get the recipients from the mailer" do
      @mock_client.should_receive(:send).with(anything, "pat@example.com", anything, anything)
      MyMailer.deliver_invitation('pat@example.com')
    end

    it "should pass body options to the mailer" do
      @mock_client.should_receive(:send).with(anything, anything, {:foo => "passed in"}, anything)
      MyMailer.deliver_invitation('pat@example.com')
    end

    it "should pass mail options to the mailer" do
      @mock_client.should_receive(:send).with(anything, anything, anything, {:replyto => "admin@example.com"})
      MyMailer.deliver_invitation('pat@example.com')
    end

    it "should send an empty hash if no body params are set" do
      @mock_client.should_receive(:send).with(anything, anything, { }, anything)
      MyMailer.deliver_with_no_body
    end

    it "should send an empty hash if no mail options are set" do
      @mock_client.should_receive(:send).with(anything, anything, anything, { })
      MyMailer.deliver_with_no_options
    end
  end
end

