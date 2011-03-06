Gem::Specification.new do |s|

	s.name = "bvm"
	s.version = '0.3.0'
	s.platform = Gem::Platform::RUBY
	s.authors = ['Guy Royse', 'Alyssa Diaz']
	s.email = ['guy@guyroyse.com']
	s.homepage = "http://github.com/guyroyse/big-visible-metrics"
	s.license = "MIT"
	s.summary = "Generates CSV files from SONAR metrics"
	s.description = "Generates CSV files that can be consumed by Microsoft Treemapper from the Sonar API.  Reads stin and stdout."
	
	s.required_rubygems_version = ">=1.3.6"
	
	s.add_runtime_dependency 'xml-simple', '~> 1.0.12'
	
	s.add_development_dependency 'rspec', '>= 2.3.0'
	s.add_development_dependency 'rspec-core', '>= 2.3.1'
	s.add_development_dependency 'rspec-expectations', '>= 2.3.0'
	
	s.files = Dir["lib/**/*"] 
	s.files += Dir["bin/*"]
	s.files << "LICENSE"
	s.files << "README.md"
	s.executables << 'bvm'
	
	s.require_path = 'lib' 
end