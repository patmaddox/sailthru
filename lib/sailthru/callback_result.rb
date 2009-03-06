module Sailthru
  class CallbackResult
    def initialize(options={})
      @send_id = options["send_id"]
      @email = options["email"]
    end

    def verified?
      @email && response["email"] == @email
    end

    private
    def response
      return {} unless @send_id
      @response ||= Sailthru.new_client.get_send(@send_id)
    end
  end
end
