
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "scad_bundler/version"

Gem::Specification.new do |spec|
  spec.name          = "scad_bundler"
  spec.version       = ScadBundler::VERSION
  spec.authors       = ["Joe Francis"]
  spec.email         = ["joe@lostapathy.com"]

  spec.summary       = %q{A package manager for OpenSCAD}
  spec.description   = %q{A package manager that leverages the power of RubyGems to package OpenSCAD libraries.}
  spec.homepage      = "https://github.com/lostapathy/scad_bundler"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  #spec.bindir        = "exe"
  spec.executables   = ['scad_bundle']
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
end
