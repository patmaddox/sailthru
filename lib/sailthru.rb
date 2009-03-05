$:.unshift File.join(File.dirname(__FILE__), 'sailthru')
require 'triggermailer_client'
require 'mailer'

module Sailthru
  API_URI = 'http://api.sailthru.com'
  VERSION = '1.0'

  class NoRecipientsSetError < RuntimeError; end
end
