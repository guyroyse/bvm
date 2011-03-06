require 'rubygems'
require 'optparse'
require 'bvm/converter'

options = { :jar => 'jar', :size => 'ncloc', :color => 'coverage', :adjust => 0 } 
  
OptionParser.new do |opts|
  opts.banner = "Usage: bvm [options]"
  opts.on("--jar JARNAME", "Assign this code to the name of JARNAME, defaults to 'jar'") do |jar|
    options[:jar] = jar
  end
  opts.on("--size METRIC", "Use this metric for the size of the treemap boxes, defaults to 'ncloc'") do |size|
    options[:size] = size
  end
  opts.on("--color METRIC", "Use this metric for the color of the treemap boxes, defaults to 'coverage'") do |color|
    options[:color] = color
  end
  opts.on("--color-adjust VALUE", "Add the following value to color metric, defaults to 0, negatives are OK") do |adjust|
    options[:adjust] = adjust.to_f
  end
end.parse!

input = STDIN.read
output = convert input, options[:jar], options[:size], options[:color], options[:adjust]
puts output
