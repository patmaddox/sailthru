module Sailthru
  class Mailer
    @deliveries = []
    @@delivery_mode = :deliver
    class << self
      attr_reader :deliveries

      def delivery_mode=(m)
        @@delivery_mode = m
      end
    end

    def initialize
      @replacements = { }
      @options = { }
    end

    def deliver(client, template)
      raise NoRecipientsSetError unless @recipients
      result = client.send(@template || template, @recipients, @replacements, @options)
      Mailer.deliveries << result
      result
    end

    def recipients(*list)
      @recipients = list.join(', ')
    end

    def template(name)
      @template = name
    end

    def body(replacements)
      @replacements.merge! replacements
    end

    def reply_to(email)
      @options[:replyto] = email
    end

    class << self
      def client
        @@delivery_mode.to_s == "test" ? FakeClient.new : TriggermailClient.new
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
