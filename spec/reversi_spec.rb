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
                pos.should == :wall
            end
        end
        0.upto(9).each do |y|
            [0,9].each do |x|
              @reversi.board[y][x].should == :wall
            end
        end
    end
  end
end
