Gem::Specification.new do |s|
  s.name = %q{riot-mongoid}
  s.version = "2.1.0"
  s.required_rubygems_version = ">= 1.3.6"
  s.authors = ["gabrielg", "Arthur Chiu"]
  s.date = Time.now.strftime("%Y-%m-%d")
  s.description = %q{A collection of assertion macros for testing Mongoid with Riot}
  s.email = %q{gabriel.gironda@gmail.com}
  s.extra_rdoc_files = ["README.md"]
  s.files = %w{LICENSE README.md Rakefile riot-mongoid.gemspec} + Dir.glob("{lib,test}/**/*")
  s.homepage = %q{http://github.com/thumblemonks/riot-mongoid}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.summary = %q{Riot assertions for Mongoid}
  s.add_dependency  "mongoid", "~> 2.1.0"
  s.add_dependency  "riot",    "~> 0.12.3"
  s.add_development_dependency "yard", ">= 0"
end

