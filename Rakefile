require 'rubygems'
require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/*.rb']
  spec.rspec_opts = ['--format', 'documentation', '--color']
end

task :default => :spec

task :build do
  sh "gem build bvm.gemspec"
end

task :install do
  sh "gem install bvm-0.3.3.gem"
end

task :uninstall do
  sh "gem uninstall bvm"
end

task :push do
  sh "gem push bvm-0.3.3.gem"
end
