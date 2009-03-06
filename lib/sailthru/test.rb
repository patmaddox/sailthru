module Sailthru
  class FakeClient
    def send(template, recipients, replacements, options)
      {:send_id => "abc123"}
    end
  end
end
