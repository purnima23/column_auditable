$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "column_auditable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "column_auditable"
  s.version     = ColumnAuditable::VERSION
  s.authors     = ["Cher Wei Soh"]
  s.email       = ["cherwei.soh@gmail.com"]
  s.homepage    = "https://github.com/cherwei/column_auditable"
  s.summary     = "Log changes of a column to your models."
  s.description = "Single column audit."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.19"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 2.0"
end
