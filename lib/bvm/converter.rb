require 'xmlsimple'

def convert(input, jar, size, color, adjust = 0)
  output = ""
  metrics = parse_xml input
  metrics[:resource].each do |resource|
    output << build_output(resource, jar, size, color, adjust)
  end
  output
end

def parse_xml(input)
  XmlSimple.xml_in input, { 'GroupTags' => { 'resources' => 'resource' }, 'KeyToSymbol' => true }
end

def build_output(resource, jar, size, color, adjust)
  name = resource[:name]
  size_metric = find_metric resource[:msr], size
  color_metric = find_metric resource[:msr], color
  color_metric += adjust
  package = parse_package resource[:key][0]  
  %Q/#{size_metric},#{color_metric},"#{jar}","#{package}","#{name}"\n/  
end

def find_metric(metrics, key)
  found_metric = nil
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

