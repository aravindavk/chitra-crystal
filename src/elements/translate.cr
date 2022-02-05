module Chitra
  struct Translate < Element
    # :nodoc:
    def initialize(@x : Float64, @y : Float64)
    end

    # :nodoc:
    def draw(cairo_ctx)
      cairo_ctx.translate @x, @y
    end

    # :nodoc:
    def to_s
      "translate(#{@x}, #{@y})"
    end
  end

  class Context
    # Translate the canvas to given x and y
    # ```
    # ctx = Chitra.new
    # ctx.translate 100, 100
    # ctx.rect 0, 0, 500, 500
    # ```
    def translate(x, y)
      t = Translate.new(x, y)
      @elements << t

      draw_on_default_surface(t)
    end
  end
end
