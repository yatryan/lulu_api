lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "lulu_api/version"

Gem::Specification.new do |spec|
  spec.name          = "lulu_api"
  spec.version       = LuluApi::VERSION
  spec.authors       = ["Taylor Ryan"]
  spec.email         = ["taylor@yatryan.com"]

  spec.summary       = "Client Library for Lulu Print on Demand API"
  spec.homepage      = "https://github.com/yatryan/lulu_api"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/yatryan/lulu_api"
  spec.metadata["changelog_uri"] = "https://github.com/yatryan/lulu_api/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"

  spec.add_dependency "httparty"
end
