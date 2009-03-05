require 'rubygems'
require 'spec'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'sailthru'

Spec::Runner.configure do |config|

end

Sailthru::API_KEY = 'fake-api-key'
Sailthru::SECRET = 'fake-api-secret'
