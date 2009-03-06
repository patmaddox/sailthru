module Sailthru
  class Delivery
    attr_reader :send_id

    def initialize(options={})
      @send_id = options["send_id"]
      @options = options.clone
    end
  end
end
