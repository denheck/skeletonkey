Gem::Specification.new do |s|
  s.name        = 'skeletonkey'
  s.version     = '1.0.0'
  s.date        = '2015-08-06'
  s.summary     = "Password Protection"
  s.description = "Simple password storage and retrieval"
  s.authors     = ["Dennis Heckman"]
  s.email       = 'denheck@gmail.com'
  s.homepage    = 'http://rubygems.org/gems/skeletonkey'
  s.license     = 'MIT'
  s.files       = Dir["lib/skeletonkey/*.rb"] + Dir['bin/*']
  s.executables << 'skeletonkey'
end
