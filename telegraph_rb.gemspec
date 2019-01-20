Gem::Specification.new do |s|
  s.name        = 'telegraph_rb'
  s.version     = '1.0.1'
  s.date        = '2019-01-15'
  s.summary     = "Telegra.ph Ruby Gem"
  s.description = "Ruby Telegra.ph API client"
  s.authors     = ["Aleksey Kiselev"]
  s.files       = Dir['lib/**/*.rb']
  s.license     = 'MIT'
  s.email       = 'aleksey_kiselev@icloud.com'
  s.homepage    = 'https://github.com/gettingud/Telegraph_rb'
  s.add_dependency 'faraday', '0.15.4'
  s.add_dependency 'faraday_middleware', '0.12.2'
  s.add_dependency 'nokogiri', '~> 1.8'
  s.add_dependency 'dry-struct', '~> 0.6'
  s.add_dependency 'json', '2.0.4'
  s.add_development_dependency 'rspec', '~> 3.7'
  s.add_development_dependency 'vcr', '~> 4.0'
  s.add_development_dependency 'webmock', '~> 3.4'
end
