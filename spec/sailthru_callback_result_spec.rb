require File.join(File.dirname(__FILE__), 'spec_helper')

describe Sailthru::CallbackResult do
  it "should not be verified when built without a send_id" do
    Sailthru::CallbackResult.new("email" => "foo").should_not be_verified
  end

  it "should not be verified when built without an email" do
    Sailthru::CallbackResult.new("send_id" => "abc123").should_not be_verified
  end

  describe "verified?" do
    before(:each) do
      @callback = Sailthru::CallbackResult.new "send_id" => "abc123", "email" => "pat@example.com"
      @client = mock("client")
      Sailthru.stub!(:new_client).and_return @client
    end

    it "should query the client once" do
      @client.should_receive(:get_send).with("abc123").and_return({})
      2.times { @callback.verified? }
    end

    it "should be true if the response contains the email" do
      @client.stub!(:get_send).and_return({"email" => "pat@example.com"})
      @callback.should be_verified
    end

    it "should be false if the response does not contain the email" do
      @client.stub!(:get_send).and_return({})
      @callback.should_not be_verified
    end

    it "should be false if the response contains a different email" do
      @client.stub!(:get_send).and_return({"email" => "wrong@address.com"})
      @callback.should_not be_verified
    end
  end
end
