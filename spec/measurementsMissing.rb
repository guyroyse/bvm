require 'bvm'

describe "BVM" do

  describe Converter do
    
    before(:each) do
      @input = File.read('spec/noMeasures.xml')
      @converter = Converter.new
    end

    it "Does not process input files with no measure tags" do
      output = @converter.convert @input
      output.should == %Q/100.0,0.8,\"jar\",\"package\",\"Class\"\n1.0,0.0,\"NotFound\",\"other.package\",\"OtherClass\"\n300.0,0.2,\"jar\",\"other.package\",\"ThirdClass\"\n/
    end
        
  end
  
end