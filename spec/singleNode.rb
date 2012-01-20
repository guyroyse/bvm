require 'bvm'

describe "BVM" do

  describe Converter do
    
    before(:each) do
      @input = File.read('spec/single.xml')
      @converter = Converter.new
    end
      
    it "defaults parameters correctly"  do
      @converter.jar.should == 'jar'
      @converter.size_metric.should == 'ncloc'
      @converter.color_metric.should == 'coverage'
      @converter.color_adjustment.should == 0.0
      @converter.invert_color_metric.should == false
    end
    
    it "converts XML to CSV for given metrics" do
      output = @converter.convert @input
      output.should == %Q/100.0,0.8,"jar","package","Class"\n/
    end
    
    it "changes the jar in the output when specified" do
      @converter.jar = 'foo'
      output = @converter.convert @input
      output.should == %Q/100.0,0.8,"foo","package","Class"\n/
    end
    
    it "changes the size metric in the output when specified" do
      @converter.size_metric = 'coverage'
      output = @converter.convert @input
      output.should == %Q/0.8,0.8,"jar","package","Class"\n/
    end
    
    it "changes the color metric in the output when specified" do
      @converter.color_metric = 'ncloc'
      output = @converter.convert @input
      output.should == %Q/100.0,100.0,"jar","package","Class"\n/
    end
    
    it "adjusts the color metric based on color adjustment" do
      @converter.color_adjustment = -0.8
      output = @converter.convert @input
      output.should == %Q/100.0,0.0,"jar","package","Class"\n/
    end
    
    it "inverts the color metric" do
      @converter.invert_color_metric = true;
      output = @converter.convert @input
      output.should == %Q/100.0,-0.8,"jar","package","Class"\n/
    end
    
    it 'inverts and adjusts by inverting first' do
      @converter.color_adjustment = 0.4
      @converter.invert_color_metric = true;
      output = @converter.convert @input
      output.should == %Q/100.0,-0.4,"jar","package","Class"\n/
    end

    it 'returns 0 for not found metrics' do
      @converter.size_metric = 'foo'
      @converter.color_metric = 'bar'
      output = @converter.convert @input
      output.should == %Q/0.0,0.0,"jar","package","Class"\n/
    end
        
  end
  
end