# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sailthru}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pat Maddox"]
  s.date = %q{2009-03-06}
  s.email = %q{pat.maddox@gmail.com}
  s.extra_rdoc_files = ["README.rdoc", "LICENSE"]
  s.files = ["README.rdoc", "VERSION.yml", "lib/sailthru", "lib/sailthru/callback_result.rb", "lib/sailthru/delivery.rb", "lib/sailthru/mailer.rb", "lib/sailthru/test.rb", "lib/sailthru/triggermailer_client.rb", "lib/sailthru.rb", "spec/sailthru_callback_result_spec.rb", "spec/sailthru_delivery_spec.rb", "spec/sailthru_mailer_spec.rb", "spec/spec_helper.rb", "LICENSE"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/pat-maddox/sailthru}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TODO}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
