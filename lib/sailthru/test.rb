module Sailthru
  class FakeClient
    def send(template, recipients, replacements, options)
      {"send_id" => Guid.new.to_s, "email" => recipients}
    end
  end
end
