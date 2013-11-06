require 'spec_helper'

describe Reversi do
  before do
      @reversi = Reversi.new 8
  end
  it 'should have a version number' do
    Reversi::VERSION.should_not be_nil
  end

  subject { @reversi }
  its(:size)  {should == 8}
  context "Reversi.board" do
    subject { @reversi.board }
    it{ should_not be_nil }
    its(:length) { should == 10}
    it do
        [0,9].each do |p|
            @reversi.board[p].each do |pos|
                pos.should == "#"
            end
        end
        0.upto(9).each do |y|
            [0,9].each do |x|
              @reversi.board[y][x].should == "#"
            end
        end
        @reversi.board[4][4].should == "W"
        @reversi.board[5][5].should == "W"
        @reversi.board[4][5].should == "B"
        @reversi.board[5][4].should == "B"
    end
  end
  context "Reversi.to_s" do
    subject { @reversi.to_s }
    its(:length) { should == 100 + 10 } # pos + \n
  end
  context "Reversi.put" do
    subject { @reversi }
    it do
        @reversi.put "W", 4,6
        @reversi.board[6][4].should == "W"
    end
    it do
        @reversi.put "B", 4,4
        @reversi.board[4][4].should == "W"
    end
    it do
        lambda{ @reversi.put "B", 100,100 }.should_not raise_error
    end
  end
  context "Reversi.reverse" do
    subject { @reversi }
    it do
        @reversi.reverse "W", 5,3
        (3..5).each do |y|
            @reversi.board[y][5].should == "W"
        end

        @reversi.reverse "B", 5,2
        @reversi.reverse "B", 5,6
        (2..6).each do |y|
            @reversi.board[y][5].should == "B"
        end

        @reversi.reverse "W", 5,1
        @reversi.reverse "W", 5,7
        (1..7).each do |y|
            @reversi.board[y][5].should == "W"
        end

        @reversi.reverse "B", 6,5
        (4..6).each do |x|
            @reversi.board[5][x].should == "B"
        end

        @reversi.reverse "B", 6,4
        @reversi.reverse "B", 3,4
        (3..6).each do |x|
            @reversi.board[4][x].should == "B"
        end

        @reversi.reverse "W", 2,3
        @reversi.board[4][3].should == "W"
        @reversi.board[5][4].should == "W"

        @reversi.reverse "W", 7,5

        @reversi.reverse "B", 3,6

        @reversi.reverse "W", 4,3
        puts @reversi
        @reversi.reverse "B", 6,2
        puts @reversi
    end
  end
end
