module Chitra
  struct Rotate < Element
    # :nodoc:
    def initialize(@angle : Float64, @center_x : Float64, @center_y : Float64)
    end

    # :nodoc:
    def draw(cairo_ctx)
      if @center_x != 0 && @center_y != 0
        cairo_ctx.translate @center_x, @center_y
        cairo_ctx.rotate @angle
        cairo_ctx.translate -@center_x, -@center_y
      else
        cairo_ctx.rotate @angle
      end
    end

    # :nodoc:
    def to_s
      "rotate(#{@angle}, center_x: #{@center_x}, center_y: #{@center_y})"
    end
  end

  class Context
    # Rotate the canvas in clockwise to given angle.
    # Negative angle rotates the canvas in anti-clockwise
    # direction.
    # ```
    # ctx = Chitra.new 200
    # ctx.rotate 45
    # ctx.rect 40, 40, 40, 40
    # ```
    # Rotate center by default is (0, 0). Change this by adding
    # arguments to rotate function
    # ```
    # ctx = Chitra.new 200
    # ctx.rotate 45, 100, 100
    # ctx.rect 50, 50, 100, 100
    # ```
    def rotate(angle, center_x = 0, center_y = 0)
      rad = Math::PI * angle / 180
      t = Rotate.new(rad, center_x, center_y)
      @elements << t
    end
  end
end
