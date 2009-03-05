module Sailthru
  class Mailer
    def deliver(client, template)
      options = {}
      if instance_variable_defined?(:@reply_to)
        options[:replyto] = @reply_to
      end
      client.send(template, @recipients, @replacements, options)
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

    def body(replacements)
      @replacements = replacements
    end

    def reply_to(email)
      @reply_to = email
    end
  end
end
