module Sailthru
  class Mailer
    def initialize
      @replacements = { }
      @options = { }
    end

    def deliver(client, template)
      raise NoRecipientsSetError unless @recipients
      client.send(template, @recipients, @replacements, @options)
    end

    def recipients(*list)
      @recipients = list.join(', ')
    end

    def body(replacements)
      @replacements.merge! replacements
    end

    def reply_to(email)
      @options[:replyto] = email
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
  end
end
