begin
  require 'rspec/core/rake_task'
  puts "RSpec loaded successfully"

  RSpec::Core::RakeTask.new(:spec)
  puts ":spec task defined"

  task :default => :spec
rescue LoadError
  puts "RSpec could not be loaded"
  # no rspec available
end
