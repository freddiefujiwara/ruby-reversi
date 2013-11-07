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
  context "Reversi.reverse" do
    subject { @reversi }
    it do
        @reversi.reverse "W", 4,6
        @reversi.board[6][4].should == "W"
    end
    it do
        @reversi.reverse "B", 4,4
        @reversi.board[4][4].should == "W"
    end
    it do
        lambda{ @reversi.reverse "B", 100,100 }.should_not raise_error
    end
    it do
        expected_walk = []
        expected_walk << {:x => 5, :y => 4}
        expected_walk.sort_by!{ |pos| pos[:x] }.sort_by!{ |pos| pos[:y] }
        @reversi.reverse("W", 5,3).should == expected_walk

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

        expected_walk  = [
            {:x => 3, :y => 4},
            {:x => 4, :y => 5}
        ].sort_by!{ |pos| pos[:x] }.sort_by!{ |pos| pos[:y] }
        @reversi.reverse("W", 2,3).should == expected_walk

        expected_walk  = [
            {:x => 5, :y => 5},
            {:x => 6, :y => 5},
            {:x => 6, :y => 4}
        ].sort_by!{ |pos| pos[:x] }.sort_by!{ |pos| pos[:y] }
        @reversi.reverse("W", 7,5).should == expected_walk

        expected_walk  = [{:x => 4, :y => 5}].sort_by!{ |pos| pos[:x] }.sort_by!{ |pos| pos[:y] }
        @reversi.reverse("B", 3,6).should == expected_walk

        expected_walk  = [{:x => 5, :y => 4}].sort_by!{ |pos| pos[:x] }.sort_by!{ |pos| pos[:y] }
        @reversi.reverse("W", 4,3).should == expected_walk

        expected_walk  = [{:x => 5, :y => 3}].sort_by!{ |pos| pos[:x] }.sort_by!{ |pos| pos[:y] }
        @reversi.reverse("B", 6,2).should == expected_walk
    end
  end
end
