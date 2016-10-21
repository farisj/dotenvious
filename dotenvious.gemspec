Gem::Specification.new do |s|
  s.name        = 'dotenvious'
  s.version     = '0.0.3'
  s.date        = '2016-10-21'
  s.summary     = "Dotenvious"
  s.description = "A Gem to manage environment variables"
  s.authors     = ["Jake Faris"]
  s.email       = 'jakefaris@outlook.com'
  s.files       = `git ls-files`.split($/)
  s.executables = ['dotenvious']
  s.homepage    = 'https://github.com/farisj/dotenvious'
  s.license       = 'MIT'

  s.add_development_dependency 'bundler', '~> 1.3'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'pry', '~> 0.10'

end
