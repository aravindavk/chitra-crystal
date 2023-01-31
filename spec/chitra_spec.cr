require "spec"

require "../src/context"

describe Chitra do
  context "width and height" do
    it "checks if default width and height are set as expected" do
      ctx = Chitra::Context.new
      ctx.width.should eq 700
      ctx.height.should eq 700
    end

    it "checks if the width and height are set by the caller" do
      ctx = Chitra::Context.new 1600, 900
      ctx.width.should eq 1600
      ctx.height.should eq 900
    end

    it "checks if the height is calculated automatically" do
      ctx = Chitra::Context.new 500
      ctx.width.should eq 500
      ctx.height.should eq 500
    end
  end

  context "rectangle and square" do
    it "checks if rectangle size is set properly" do
      ctx = Chitra::Context.new
      ctx.rect 50, 50, 200, 100
      ctx.elements.size.should eq 1
      ele = ctx.elements[0].as(Chitra::Rect)
      ele.@x.should eq 50
      ele.@y.should eq 50
      ele.@w.should eq 200
      ele.@h.should eq 100
    end

    it "checks if square size is set properly" do
      ctx = Chitra::Context.new
      ctx.rect 50, 50, 200
      ctx.elements.size.should eq 1
      ele = ctx.elements[0].as(Chitra::Rect)
      ele.@x.should eq 50
      ele.@y.should eq 50
      ele.@w.should eq 200
      ele.@h.should eq 200
    end
  end

  context "Oval and Circle" do
    it "checks if Oval size is set properly" do
      ctx = Chitra::Context.new
      ctx.oval 50, 50, 200, 100
      ctx.elements.size.should eq 1
      ele = ctx.elements[0].as(Chitra::Oval)
      ele.@x.should eq 50
      ele.@y.should eq 50
      ele.@w.should eq 200
      ele.@h.should eq 100
    end

    it "checks if Circle size is set properly" do
      ctx = Chitra::Context.new
      ctx.oval 50, 50, 200
      ctx.elements.size.should eq 1
      ele = ctx.elements[0].as(Chitra::Oval)
      ele.@x.should eq 50
      ele.@y.should eq 50
      ele.@w.should eq 200
      ele.@h.should eq 200
    end
  end
end
