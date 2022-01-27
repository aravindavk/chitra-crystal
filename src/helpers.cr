require "cairo"

at_exit do
  GC.collect
end

module Chitra
  include Cairo

  struct LineDash
    property enabled = false, values = [] of Float64, offset = 0.0

    def initialize
    end
  end

  module ShapeProperties
    property fill = Color.new,
      stroke = Color.new,
      stroke_width = 1,
      no_fill = false,
      line_dash = LineDash.new,
      line_cap = Cairo::LineCap::Butt,
      line_join = Cairo::LineJoin::Miter
  end

  abstract struct Element
    include ShapeProperties

    def draw_shape_properties(cairo_ctx)
      if @no_fill
        cairo_ctx.set_source_rgba 0, 0, 0, 0
      else
        cairo_ctx.set_source_rgba @fill.r, @fill.g, @fill.b, @fill.a
      end

      if @stroke_width > 0
        cairo_ctx.fill_preserve
        cairo_ctx.line_width = @stroke_width
        if @line_dash.enabled
          cairo_ctx.set_dash(@line_dash.values, @line_dash.offset)
        else
          cairo_ctx.set_dash([] of Float64, 0)
        end
        cairo_ctx.line_cap = @line_cap
        cairo_ctx.line_join = @line_join
        cairo_ctx.set_source_rgba @stroke.r, @stroke.g, @stroke.b, @stroke.a
        cairo_ctx.stroke
      else
        cairo_ctx.fill
      end
    end

    def fill_debug_text
      @no_fill ? "fill=nil" : "fill=#{@fill.debug}"
    end

    def stroke_debug_text
      if stroke_width > 0
        "stroke=#{@stroke.debug} stroke_width=#{@stroke_width}"
      else
        "stroke=nil"
      end
    end

    def line_dash_debug_text
      if @line_dash.enabled
        "line_dash=(#{@line_dash.values.join(",")}, offset: #{@line_dash.offset})"
      else
        "line_dash=nil"
      end
    end

    # :nodoc:
    def debug_text(shape_msg)
      "#{shape_msg} #{fill_debug_text} #{stroke_debug_text} " +
        "#{line_dash_debug_text} line_cap=#{@line_cap} " +
        "line_join=#{@line_join}"
    end
  end

  abstract struct Surface
    property output_file = ""
  end

  struct Color
    property r = 0.0, g = 0.0, b = 0.0, a = 1.0

    def initialize
    end

    def debug
      "RGBA(%.2f, %.2f, %.2f, %.2f)" % {@r, @g, @b, @a}
    end
  end

  struct Size
    property width = 700, height = 700

    def initialize
    end
  end

  class Context
    # :nodoc:
    # Validate the RGBA values
    private def color_validate(r, g, b, a)
      if r < 0 || r > 1 || g < 0 || g > 1 || b < 0 || b > 1 || a < 0 || a > 1
        raise Exception.new("Invalid color value RGBA(%.2f, %.2f, %.2f, %.2f)" % {r, g, b, a})
      end
    end

    private def coord_pairs_validate(values)
      points = [] of Array(Float64)
      values.each_slice(2) do |point|
        raise Exception.new "Invalid point pairs" if point.size != 2
        points << (point.map &.to_f64).to_a
      end

      points
    end

    private def add_shape_properties(ele)
      ele.fill = @fill
      ele.stroke = @stroke
      ele.stroke_width = @stroke_width
      ele.no_fill = @no_fill
      ele.line_dash = @line_dash
      ele.line_cap = @line_cap
      ele.line_join = @line_join
      @elements << ele

      # Return the element index
      @elements.size - 1
    end
  end
end
