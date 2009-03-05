module Sailthru
  class Mailer
    def deliver(client, template)
      client.send(template, @recipients, :ignore, :ignore)
    end

    class << self
      def client
        TriggermailClient.new
      end

      def method_missing(m, *args, &block)
        if /^deliver_(.*)$/ =~ m.to_s && instance_methods.include?($1)
          message = new
          message.send($1, *args, &block)
          message.deliver client, $1
        else
          super
        end
      end
    end

    def recipients(*list)
      @recipients = list.join(', ')
    end
  end
end
