require 'xmlsimple'

class Converter
  attr_accessor :jar
  attr_accessor :size_metric
  attr_accessor :color_metric
  attr_accessor :color_adjustment
  attr_accessor :invert_color_metric
  
  def initialize
    @jar = 'jar'
    @size_metric = 'ncloc'
    @color_metric = 'coverage'
    @color_adjustment = 0.0
    @invert_color_metric = false
  end
  
  def convert(input)
    output = ""
    metrics = parse_xml input
    metrics[:resource].each do |resource|
      output << build_output(resource, @jar, @size_metric, @color_metric, @color_adjustment)
    end
    output
  end
  
  def parse_xml(input)
    XmlSimple.xml_in input, { 'GroupTags' => { 'resources' => 'resource' }, 'KeyToSymbol' => true }
  end
  
  def build_output(resource, jar, size, color, adjust)
    name = resource[:name][0]
    size_metric = find_metric resource[:msr], size
    color_metric = find_metric resource[:msr], color
    color_metric *= -1 unless not @invert_color_metric
    color_metric += adjust
    package = parse_package resource[:key][0]  
    %Q/#{size_metric},#{color_metric},"#{jar}","#{package}","#{name}"\n/  
  end
  
  def find_metric(metrics, key)
    found_metric = 0.0
    metrics.each do |metric|
      if key == metric[:key][0] then
        found_metric = metric[:val][0].to_f
      end
    end
    found_metric
  end
  
  def parse_package(full_name)
    temp = /^.*\./.match full_name
    /^.*[^\.]/.match(temp.to_s)
  end

end
