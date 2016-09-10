Gem::Specification.new do |s|
  s.name        = 'dotenvious'
  s.version     = '0.0.0'
  s.date        = '2016-04-23'
  s.summary     = "Dotenvious"
  s.description = "A dotenv wrapper to manage variables"
  s.authors     = ["Jake Faris"]
  s.email       = 'jakefaris@outlook.com'
  s.files       = `git ls-files`.split($/)
  s.executables = ['dotenvious']
  s.homepage    =
    'http://rubygems.org/gems/dotenvious'
  s.license       = 'MIT'

  s.add_development_dependency 'bundler', '~> 1.3'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'pry'

end
