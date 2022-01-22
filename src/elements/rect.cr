module Chitra
  struct Rect < Element
    include ShapeProperties

    # :nodoc:
    def initialize(@x : Float64, @y : Float64, @w : Float64, @h : Float64)
    end

    # :nodoc:
    def draw(cairo_ctx)
      cairo_ctx.rectangle @x, @y, @w, @h
      if @stroke_width > 0
        cairo_ctx.line_width = @stroke_width
        cairo_ctx.set_source_rgba @stroke.r, @stroke.g, @stroke.b, @stroke.a
        cairo_ctx.stroke_preserve
      end

      if @no_fill
        cairo_ctx.set_source_rgba 0, 0, 0, 0
      else
        cairo_ctx.set_source_rgba @fill.r, @fill.g, @fill.b, @fill.a
      end
      cairo_ctx.fill
    end

    # :nodoc:
    def to_s
      fill_data = @no_fill ? "fill=nil" : "fill=#{@fill}"
      stroke_data = @stroke_width > 0 ? "stroke=#{@stroke} stroke_width=#{@stroke_width}" : "stroke=nil"
      "rect(#{@x}, #{@y}, #{@w}, #{@h}) #{fill_data} #{stroke_data}"
    end
  end

  class Context
    # Draw rectangle shape
    # ```
    # ctx = Chitra.new
    # x y w h
    # ctx.rect 100, 100, 500, 500
    # ```
    def rect(x, y, w, h)
      r = Rect.new(x, y, w, h)
      r.fill = @fill
      r.stroke = @stroke
      r.stroke_width = @stroke_width
      r.no_fill = @no_fill
      @elements << r

      r
    end
  end
end
