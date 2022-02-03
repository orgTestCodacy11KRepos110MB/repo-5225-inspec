# As plugins are usually packaged and distributed as a RubyGem,
# we have to provide a .gemspec file, which controls the gembuild
# and publish process.  This is a fairly generic gemspec.

# It is traditional in a gemspec to dynamically load the current version
# from a file in the source tree.  The next three lines make that happen.
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "inspec-streamer-bang/version"

Gem::Specification.new do |spec|
  # Importantly, all InSpec plugins must be prefixed with `inspec-` (most
  # plugins) or `train-` (plugins which add new connectivity features).
  spec.name          = "inspec-streamer-bang"

  # It is polite to namespace your plugin under InspecPlugins::YourPluginInCamelCase
  spec.version       = InspecPlugins::StreamerBang::VERSION
  spec.authors       = ["Progress Chef InSpec Team"]
  spec.email         = ["inspec@chef.io"]
  spec.summary       = "A test plugin for the streaming reporter"
  spec.description   = ""
  spec.homepage      = "https://github.com/inspec/inspec"
  spec.license       = "Apache-2.0"

  # Though complicated-looking, this is pretty standard for a gemspec.
  # It just filters what will actually be packaged in the gem (leaving
  # out tests, etc)
  spec.files = %w{
    README.md inspec_streamer_bang.gemspec Gemfile
  } + Dir.glob(
    "lib/**/*", File::FNM_DOTMATCH
  ).reject { |f| File.directory?(f) }
  spec.require_paths = ["lib"]

  # If you rely on any other gems, list them here with any constraints.
  # This is how `inspec plugin install` is able to manage your dependencies.
  # For example, perhaps you are writing a thing that talks to AWS, and you
  # want to ensure you have `aws-sdk` in a certain version.

  # All plugins should mention inspec, > 2.2.78
  # 2.2.78 included the v2 Plugin API
  spec.add_dependency "inspec", ">= 2.2.78", "< 4.0.0"
end
