Gem::Specification.new do |gem|
  gem.name = "Ruby_Dice"
  gem.version = "1.0.0" unless ENV['TRAVIS']
  gem.version = ENV['TRAVIS_TAG'] if ENV['TRAVIS'] # Travis CI takes your tag and uses it for the version
  gem.version = ENV['TRAVIS_BUILD_ID'] if ENV['TRAVIS'] && ENV["TRAVIS_TAG"] == ""
  gem.files = Dir["lib/*.rb"]
  gem.email = "zrp200@gmail.com", "zenitram.oiram@gmail.com"
  gem.bindir = "bin"
  gem.extra_rdoc_files = Dir["*.md"]
  gem.summary = "A Yahtzee clone written in Ruby that runs in the terminal"
  gem.description = <<DIS
This project is a personal project for educational purposes and becoming accustomed to the Ruby programming paradigm.
Furthermore, it's to become accustomed to the Git workflow.
Contributions are most welcome!
DIS
  gem.executables << "Ruby_Dice"
  gem.authors = "Zachary Perlmutter", "Mario Martinez"
  gem.add_development_dependency "rspec", ">= 3.1"
  gem.add_development_dependency "rspec-its"
  gem.homepage = "https://rubygems.org/gems/Ruby_Dice"
  gem.license = "MIT"
  gem.required_ruby_version = ">= 1.9.2"
  gem.requirements << "Terminal"
end
