require 'bvm'

describe "BVM" do

  describe Converter do
    
    before(:each) do
      @input = File.read('spec/multiple.xml')
      @converter = Converter.new
    end

    it "converts XML to CSV for given metrics" do
      output = @converter.convert @input
      output.should == %Q/100.0,0.8,\"jar\",\"package\",\"Class\"\n200.0,0.6,\"jar\",\"other.package\",\"OtherClass\"\n300.0,0.2,\"jar\",\"other.package\",\"ThirdClass\"\n/
    end
    
    it "changes the jar in the output when specified" do
      @converter.jar = 'foo'
      output = @converter.convert @input
      output.should == %Q/100.0,0.8,\"foo\",\"package\",\"Class\"\n200.0,0.6,\"foo\",\"other.package\",\"OtherClass\"\n300.0,0.2,\"foo\",\"other.package\",\"ThirdClass\"\n/
    end
    
    it "changes the size metric in the output when specified" do
      @converter.size_metric = 'coverage'
      output = @converter.convert @input
      output.should == %Q/0.8,0.8,\"jar\",\"package\",\"Class\"\n0.6,0.6,\"jar\",\"other.package\",\"OtherClass\"\n0.2,0.2,\"jar\",\"other.package\",\"ThirdClass\"\n/
    end
    
    it "changes the color metric in the output when specified" do
      @converter.color_metric = 'ncloc'
      output = @converter.convert @input
      output.should == %Q/100.0,100.0,\"jar\",\"package\",\"Class\"\n200.0,200.0,\"jar\",\"other.package\",\"OtherClass\"\n300.0,300.0,\"jar\",\"other.package\",\"ThirdClass\"\n/
    end
    
    it "adjusts the color metric based on color adjustment" do
      @converter.color_adjustment = -2.0
      output = @converter.convert @input
      output.should == %Q/100.0,-1.2,"jar","package","Class"\n200.0,-1.4,"jar","other.package","OtherClass"\n300.0,-1.8,"jar","other.package","ThirdClass"\n/
    end
    
    it 'inverts and adjusts by inverting first' do
      @converter.color_adjustment = 2.0
      @converter.invert_color_metric = true;
      output = @converter.convert @input
      output.should == %Q/100.0,1.2,"jar","package","Class"\n200.0,1.4,"jar","other.package","OtherClass"\n300.0,1.8,"jar","other.package","ThirdClass"\n/
    end

    it "inverts the color metric" do
      @converter.invert_color_metric = true;
      output = @converter.convert @input
      output.should == %Q/100.0,-0.8,"jar","package","Class"\n200.0,-0.6,"jar","other.package","OtherClass"\n300.0,-0.2,"jar","other.package","ThirdClass"\n/
    end

    it 'returns 0 for not found metrics' do
      @converter.size_metric = 'foo'
      @converter.color_metric = 'bar'
      output = @converter.convert @input
      output.should == %Q/0.0,0.0,"jar","package","Class"\n0.0,0.0,"jar","other.package","OtherClass"\n0.0,0.0,"jar","other.package","ThirdClass"\n/
    end
    
    it 'converts input with multiple lines' do
      output = @converter.convert @input
      output.should == %Q/100.0,0.8,"jar","package","Class"\n200.0,0.6,"jar","other.package","OtherClass"\n300.0,0.2,"jar","other.package","ThirdClass"\n/
    end
        
  end
  
end