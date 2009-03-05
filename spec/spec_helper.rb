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

  def with_custom_template
    template 'super_template'
    recipients 'ignore@ignore.com'
  end

  def with_no_recipients
    body :ignore => 'ignore'
  end

  def with_no_body
    recipients "foo@blah.com"
    reply_to "ignore"
  end

  def with_no_reply_to
    recipients "foo@blah.com"
    body :ignore => 'ignore'
  end
end
