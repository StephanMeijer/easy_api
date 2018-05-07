
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "easy_api"

Gem::Specification.new do |spec|
  spec.name          = "easy_api"
  spec.version       = EasyApi::VERSION
  spec.authors       = ["Stephan Meijer"]
  spec.email         = ["me@stephanmeijer.com"]

  spec.summary       = %q{The first real Telegram API client}

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
