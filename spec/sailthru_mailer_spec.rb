require File.join(File.dirname(__FILE__), 'spec_helper')


describe Sailthru::Mailer do
  it "should create a client" do
    Sailthru.mode = :deliver
    Sailthru.new_client.should be_kind_of(Sailthru::TriggermailClient)
  end

  describe "mode" do
    it "should create a client when mode is deliver" do
      Sailthru.mode = :deliver
      c = stub("client", :null_object => true)
      Sailthru::TriggermailClient.should_receive(:new).and_return c
      MyMailer.deliver_invitation 'pat.maddox@gmail.com'
    end

    it "should not create a client when mode is test" do
      Sailthru.mode = :test
      Sailthru::TriggermailClient.should_not_receive(:new)
      MyMailer.deliver_invitation 'pat.maddox@gmail.com'
    end
  end

  describe "sending an email" do
    before(:each) do
      @mock_client = mock('client', :send => {:send_id => "abc123"})
      Sailthru::TriggermailClient.stub!(:new).and_return @mock_client
      Sailthru.mode = :deliver
    end

    it "should create a client for each email sent" do
      c = stub("client", :null_object => true)
      Sailthru::TriggermailClient.should_receive(:new).twice.and_return c
      2.times { MyMailer.deliver_invitation('pat@example.com') }
    end

    it "should infer the template name" do
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

    it "should pass reply-to to the mailer" do
      @mock_client.should_receive(:send).with(anything, anything, anything, {:replyto => "admin@example.com"})
      MyMailer.deliver_invitation('pat@example.com')
    end

    it "should allow the template to be overridden" do
      @mock_client.should_receive(:send).with('super_template', anything, anything, anything)
      MyMailer.deliver_with_custom_template
    end

    it "should blow up if recipients is not set" do
      lambda { MyMailer.deliver_with_no_recipients }.
        should raise_error(Sailthru::NoRecipientsSetError)
    end

    it "should send an empty hash if no body params are set" do
      @mock_client.should_receive(:send).with(anything, anything, { }, anything)
      MyMailer.deliver_with_no_body
    end

    it "should send an empty hash if reply-to is not set" do
      @mock_client.should_receive(:send).with(anything, anything, anything, { })
      MyMailer.deliver_with_no_reply_to
    end
  end
end

