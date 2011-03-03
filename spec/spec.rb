require 'src/converter'

describe "Big Visible Metrics" do

  before(:each) do
    @input = File.read('spec/simple.xml')
  end
    
  it "Converts XML to CSV for given metrics" do
    output = convert @input, 'jar', 'ncloc', 'coverage'
    output.should == %Q/100.0,0.8,"jar","package","Class"\n200.0,0.6,"jar","other.package","OtherClass"\n/
  end
  
  it "Adjusts color metrics" do
    output = convert @input, 'jar', 'ncloc', 'coverage', -0.8
    output.should == %Q/100.0,0.0,"jar","package","Class"\n200.0,-0.2,"jar","other.package","OtherClass"\n/
  end
  
end