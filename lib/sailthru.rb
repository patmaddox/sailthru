require 'sailthru/triggermailer_client'
require 'sailthru/mailer'
require 'sailthru/delivery'
require 'sailthru/callback_result'

module Sailthru
  API_URI = 'http://api.sailthru.com'
  VERSION = '1.0'

  class << self
    attr_writer :mode

    def new_client
      @mode.to_s == "test" ? FakeClient.new : TriggermailClient.new
    end
  end

  class NoRecipientsSetError < RuntimeError; end
end
