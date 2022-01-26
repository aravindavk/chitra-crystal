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
      line_dash = LineDash.new
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
        cairo_ctx.set_source_rgba @stroke.r, @stroke.g, @stroke.b, @stroke.a
        cairo_ctx.stroke
      else
        cairo_ctx.fill
      end
    end

    # :nodoc:
    def debug_text(shape_msg)
      fill_data = @no_fill ? "fill=nil" : "fill=#{@fill.debug}"
      stroke_data = @stroke_width > 0 ? "stroke=#{@stroke.debug} stroke_width=#{@stroke_width}" : "stroke=nil"
      line_dash = @line_dash.enabled ? "line_dash=(#{@line_dash.values.join(",")}, offset: #{@line_dash.offset})" : "line_dash=nil"
      "#{shape_msg} #{fill_data} #{stroke_data} #{line_dash}"
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

    private def add_shape_properties(ele)
      ele.fill = @fill
      ele.stroke = @stroke
      ele.stroke_width = @stroke_width
      ele.no_fill = @no_fill
      ele.line_dash = @line_dash
      @elements << ele

      # Return the element index
      @elements.size - 1
    end
  end
end
