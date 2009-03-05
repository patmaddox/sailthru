require 'rubygems'
require 'spec'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'sailthru'

Spec::Runner.configure do |config|

end

Sailthru::API_KEY = 'fake-api-key'
Sailthru::SECRET = 'fake-api-secret'

class MyMailer < Sailthru::Mailer
  def invitation(email_address)
    recipients email_address
    body :foo => "passed in"
    reply_to "admin@example.com"
  end

  def with_no_body
    reply_to "ignore"
  end

  def with_no_options
    body :ignore => 'ignore'
  end
end
