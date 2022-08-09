require "spec"

require "../src/global_context"

describe Chitra do
  context "width and height" do
    it "checks if default width and height are set as expected" do
      width.should eq 700
      height.should eq 700
    end

    it "checks if the width and height are set by the caller" do
      size 1600, 900
      width.should eq 1600
      height.should eq 900
    end

    it "checks if the height is calculated automatically" do
      size 500
      width.should eq 500
      height.should eq 500
    end
  end

  context "rectangle and square" do
    it "checks if rectangle size is set properly" do
      size 700
      rect 50, 50, 200, 100
      Chitra.global_context.elements.size.should eq 1
      ele = Chitra.global_context.elements[0].as(Chitra::Rect)
      ele.@x.should eq 50
      ele.@y.should eq 50
      ele.@w.should eq 200
      ele.@h.should eq 100
    end

    it "checks if square size is set properly" do
      size 700
      rect 50, 50, 200
      Chitra.global_context.elements.size.should eq 1
      ele = Chitra.global_context.elements[0].as(Chitra::Rect)
      ele.@x.should eq 50
      ele.@y.should eq 50
      ele.@w.should eq 200
      ele.@h.should eq 200
    end
  end

  context "Oval and Circle" do
    it "checks if Oval size is set properly" do
      size 700
      oval 50, 50, 200, 100
      Chitra.global_context.elements.size.should eq 1
      ele = Chitra.global_context.elements[0].as(Chitra::Oval)
      ele.@x.should eq 50
      ele.@y.should eq 50
      ele.@w.should eq 200
      ele.@h.should eq 100
    end

    it "checks if Circle size is set properly" do
      size 700
      oval 50, 50, 200
      Chitra.global_context.elements.size.should eq 1
      ele = Chitra.global_context.elements[0].as(Chitra::Oval)
      ele.@x.should eq 50
      ele.@y.should eq 50
      ele.@w.should eq 200
      ele.@h.should eq 200
    end
  end
end
