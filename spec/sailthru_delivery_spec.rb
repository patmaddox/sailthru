require File.join(File.dirname(__FILE__), 'spec_helper')

describe Sailthru::Delivery do
  before(:each) do
    @delivery = MyMailer.deliver_invitation 'pat.maddox@gmail.com'
  end

  it "should add the message to the list of deliveries" do
    Sailthru::Mailer.deliveries.should == [@delivery]
  end
end
