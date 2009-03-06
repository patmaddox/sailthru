require 'sailthru/triggermailer_client'
require 'sailthru/mailer'
require 'sailthru/delivery'

module Sailthru
  API_URI = 'http://api.sailthru.com'
  VERSION = '1.0'

  class << self
    attr_writer :mode

    def test_mode?
      @mode.to_s == "test"
    end
  end

  class NoRecipientsSetError < RuntimeError; end
end
