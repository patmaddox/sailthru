require File.join(File.dirname(__FILE__), 'spec_helper')

describe Sailthru::Delivery do
  describe "when sent" do
    before(:each) do
      @delivery = MyMailer.deliver_invitation 'pat.maddox@gmail.com'
    end

    it "should be a kind of delivery" do
      @delivery.should be_instance_of(Sailthru::Delivery)
    end

    it "should add the message to the list of deliveries" do
      Sailthru::Mailer.deliveries.should == [@delivery]
    end
  end

  it "should not be successful when built without a send_id" do
    Sailthru::Delivery.new(:send_id => nil).should_not be_success
  end

  it "should expose the send_id" do
    Sailthru::Delivery.new(:send_id => "abc123").send_id.should == "abc123"
  end

  describe "success?" do
    before(:each) do
      @delivery = Sailthru::Delivery.new :send_id => "abc123"
      @client = mock("client")
      Sailthru.stub!(:new_client).and_return @client
    end

    it "should query the client once" do
      @client.should_receive(:get_send).with("abc123").and_return({})
      2.times { @delivery.success? }
    end

    it "should be true if the response contains the email" do
      @client.stub!(:get_send).and_return({"email" => "pat@example.com"})
      @delivery.should be_success
    end

    it "should be false if the response does not contain the email" do
      @client.stub!(:get_send).and_return({})
      @delivery.should_not be_success
    end
  end
end
