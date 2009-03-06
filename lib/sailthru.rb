require 'sailthru/triggermailer_client'
require 'sailthru/mailer'
require 'sailthru/delivery'

module Sailthru
  API_URI = 'http://api.sailthru.com'
  VERSION = '1.0'

  class NoRecipientsSetError < RuntimeError; end
end
