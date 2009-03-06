module Sailthru
  class Delivery
    attr_reader :send_id, :email

    def initialize(options={})
      @send_id = options["send_id"]
      @email = options["email"]
      @options = options.clone
    end
  end
end
