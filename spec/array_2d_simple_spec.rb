require 'spec_helper.rb'

module Array2dSimple
  describe Array2d do
    let(:array_2d) { Array2d.new(width:8, height: 2) }

    before do
      Printer.stub( :log )
    end

    it 'creates' do
      array_2d.class.should eq Array2d
    end

    it 'creates different size' do
      big_array = Array2d.new(width: 30, height: 100)
      big_array.to_s.should include '30x100'
    end

    describe 'enumerable' do
      it 'each calls the block with the current value' do
        a2x2 = Array2d.new(width: 2, height: 2)
        a2x2.set_by_xy(0,0,1)
        a2x2.set_by_xy(0,1,2)
        a2x2.set_by_xy(1,0,3)
        a2x2.set_by_xy(1,1,4)

        foo = []
        a2x2.each { |element| foo << element }
        foo.should == [1,2,3,4]
      end
    end

    context 'shared' do
      let( :getter_warning ){ 'Warning: #get_by_rc is depricated. Use get_by_xy. Note: arguments are reversed with get_by_xy'}
      let( :setter_warning ){ 'Warning: #set_by_rc is depricated. Use set_by_xy. Note: arguments are reversed with set_by_xy'}

      before do
        proc = Proc.new { |x, y| x * 8 + y + 1}
        array_2d.set_each &proc
      end

      it 'fills Array2d' do
        array_2d.get_by_xy(0,0).should eq 1
        array_2d.get_by_xy(7,0).should eq 8
        array_2d.get_by_xy(1,1).should eq 10
        array_2d.get_by_xy(3,1).should eq 12
        array_2d.get_by_xy(7,1).should eq 16
      end

      it 'gets by rc is deprecated' do
        Printer.should_receive( :log ).with getter_warning
        array_2d.get_by_rc(1,4).should eq 13
      end

      it 'sets by rc is deprecated' do
        Printer.should_receive( :log ).with setter_warning
        array_2d.set_by_rc(1,4, 13).should eq 13
      end

      it 'gets_by_x_y' do
        array_2d.get_by_xy(5,1).should eq 14
      end

      it 'gets [x,y]' do
        array_2d[5,1].should eq 14
      end

      it 'sets [x,y]' do
        array_2d[2,1] = 88
        array_2d[2,1].should eq 88
      end

      it 'prints Array2d' do
         array_2d.output.class.should eq String
      end

      it 'gets max' do
        array_2d.max.should eq 16
      end

      it 'gets min' do
        array_2d.min.should eq 1
      end

      it 'projects values to new Array2d' do
        proc = Proc.new { |i| i * 4 }
        projection = array_2d.project &proc
        projection.class.should eq array_2d.class
        projection.to_s.should eq array_2d.to_s
        projection[3,1].should eq array_2d[3,1] * 4
      end

      it 'raises x out of range exception' do
        expect { array_2d[8,0] }.to raise_error 'x out of range'
        expect { array_2d[0,2] }.to raise_error 'y out of range'
      end
    end
  end
end