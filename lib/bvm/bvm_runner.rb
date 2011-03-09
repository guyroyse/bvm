require 'rubygems'
require 'optparse'
require 'bvm/converter'

converter = Converter.new

OptionParser.new do |opts|
  opts.banner = "Usage: bvm [options]"
  opts.on("--jar JARNAME", "Assign this code to the name of JARNAME, defaults to 'jar'") do |jar|
    converter.jar = jar
  end
  opts.on("--size METRIC", "Use this metric for the size of the treemap boxes, defaults to 'ncloc'") do |size|
    converter.size_metric = size
  end
  opts.on("--color METRIC", "Use this metric for the color of the treemap boxes, defaults to 'coverage'") do |color|
    converter.color_metric = color
  end
  opts.on("--color-adjust VALUE", "Add the following value to color metric, defaults to 0, negatives are OK") do |adjust|
    converter.color_adjustment = adjust.to_f
  end
  opts.on("--invert-color", "Inverts the color metric making it negative if positive and vice versa, executes before --color-adjust, defaults to false") do
    converter.invert_color_metric = true
  end
end.parse!

puts converter.convert(STDIN.read)
