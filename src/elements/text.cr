module Chitra
  struct Text < Element
    include ShapeProperties
    include TextProperties

    # :nodoc:
    def initialize(@txt : String, @x : Float64, @y : Float64)
    end

    # :nodoc:
    def draw(cairo_ctx)
      cairo_ctx.select_font_face(@font.family, @font.slant, @font.weight)
      cairo_ctx.font_size = @font.height
      cairo_ctx.move_to(@x, @y)
      cairo_ctx.text_path(@txt)
      draw_shape_properties(cairo_ctx)
    end

    # :nodoc:
    def to_s
      debug_text "text(#{@txt[0..6]}#{@txt.size > 7 ? ".." : ""}, #{@x}, #{@y})"
    end
  end

  class Context
    # Draw text for given x and y values.
    # ```
    # text "Hello World", 100, 100
    # ```
    def text(txt, x, y)
      t = Text.new(txt, x, y)
      add_shape_properties(t)
    end
  end
end
