require "cairo"

at_exit do
  GC.collect
end

module Chitra
  include Cairo

  abstract struct Element
  end

  struct Color
    property r = 0.0, g = 0.0, b = 0.0, a = 0.0

    def initialize
    end

    def to_s
      "rgba(%.2f, %.2f, %.2f, %.2f)" % {@r, @g, @b, @a}
    end
  end

  struct Size
    property width = 700, height = 700

    def initialize
    end
  end

  module ShapeProperties
    property fill = Color.new,
      stroke = Color.new,
      stroke_width = 1,
      no_fill = false
  end

  class Context
    private def color_validate(r, g, b, a)
      if r < 0 || r > 1 || g < 0 || g > 1 || b < 0 || b > 1 || a < 0 || a > 1
        raise Exception.new("Invalid color value RGBA(#{r}, #{g}, #{b}, #{a})")
      end
    end
  end
end
