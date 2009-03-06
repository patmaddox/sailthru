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

    it "should expose the send_id" do
      @delivery.send_id.should_not be_nil
    end

    it "should expose the email" do
      @delivery.email.should_not be_nil
    end
  end
end
