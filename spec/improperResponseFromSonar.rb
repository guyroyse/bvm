require 'bvm'

describe "BVM" do

  describe Converter do
    
    before(:each) do
      @input = File.read('spec/noResources.xml')
      @converter = Converter.new
    end

    it "Does not process input files with no resource tags" do
      output = @converter.convert @input
      output.should == ""
    end
        
  end
  
end