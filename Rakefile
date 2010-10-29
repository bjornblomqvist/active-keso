require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "active-keso"
    gem.summary = %Q{A way to get cottage cheese out off activerecord}
    gem.description = %Q{A way to get cottage cheese out off activerecord}
    gem.email = "darwin.git@marianna.se"
    gem.homepage = "http://github.com/bjornblomqvist/active-keso"
    gem.authors = ["Darwin"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency "sqlite3-ruby"
    gem.add_dependency "activerecord", ">= 2.3.5"
    gem.add_dependency "keso", ">= 0.1.3"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "active-keso #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
