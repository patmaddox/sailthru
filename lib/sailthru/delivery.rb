module Sailthru
  class Delivery
    attr_reader :send_id

    def initialize(response={})
      @send_id = response["send_id"]
    end

    def success?
      response["email"]
    end

    def response
      return {} unless @send_id
      @response ||= Sailthru.new_client.get_send(@send_id)
    end
  end
end
