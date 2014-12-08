Gem::Specification.new do |gem|
  gem.name = "ruby-dice"
  gem.version = "0.0.0"
  gem.files = Dir.glob "lib/*.rb"
  gem.emails = "zrp200@gmail.com", "zenitram.oiram@gmail.com"
  gem.extra_rdoc_files = Dir.glob "*.md"
  gem.summary = "A Yahtzee clone written in Ruby that runs in the terminal"
  gem.discription = <<DIS
This project is a personal project for educational purposes and becoming accustomed to the ruby programming paradigm.
Furthermore, it's to become accustomed to the git workflow.
Contributions are most welcome!
DIS
  gem.executables << "Ruby-Dice"
  gem.authors = "Zachary Perlmutter", "Mario Martinez"
  gem.add_development_dependency "rspec", ">= 3.1"
  gem.add_development_dependency "rspec-its"
  gem.license = "MIT"
end
