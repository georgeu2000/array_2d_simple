require 'spec_helper.rb'

module Array2dSimple
  describe NormalizedArray2d do
    let(:array_2d) { Array2d.new(width:8, height:2) }

    before do
      Printer.stub( :log )
    end

    it 'gets normalized value' do
      array_2d.set_each { |x, y| x * 8 + y + 1}
      normalized_array = NormalizedArray2d.new(array_2d)
      normalized_array[0,0].should eq 0.0
      normalized_array[3,0].should eq 0.2
      normalized_array[7,1].should eq 1.0
    end

  end

end