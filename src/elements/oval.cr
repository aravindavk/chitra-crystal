module Chitra
  struct Oval < Element
    include ShapeProperties

    # :nodoc:
    def initialize(@x : Float64, @y : Float64, @w : Float64, @h : Float64)
    end

    # :nodoc:
    def draw(cairo_ctx)
      cairo_ctx.save
      cairo_ctx.translate(@x + @w/2, @y + @h/2)
      cairo_ctx.scale(@w/2, @h/2)
      cairo_ctx.arc(0.0, 0.0, 1.0, 0.0, 2.0 * Math::PI)

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

      cairo_ctx.restore
    end

    # :nodoc:
    def to_s
      fill_data = @no_fill ? "fill=nil" : "fill=#{@fill}"
      stroke_data = @stroke_width > 0 ? "stroke=#{@stroke} stroke_width=#{@stroke_width}" : "stroke=nil"
      "oval(#{@x}, #{@y}, #{@w}, #{@h}) #{fill_data} #{stroke_data}"
    end
  end

  class Context
    # Draw oval shape
    # ```
    # ctx = Chitra.new
    # x y w h
    # ctx.oval 100, 100, 500, 500
    # ```
    def oval(x, y, w, h)
      o = Oval.new(x, y, w, h)
      o.fill = @fill
      o.stroke = @stroke
      o.stroke_width = @stroke_width
      o.no_fill = @no_fill
      @elements << o

      o
    end
  end
end
