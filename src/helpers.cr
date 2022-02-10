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

  struct Font
    property family = "Serif", slant = "Normal",
      weight = "Normal", height = 12

    def initialize
    end
  end

  module TextProperties
    property font = Font.new, line_height = 1.5, align = "left", hyphenation = false, hyphen_char = "-"
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
    include TextProperties

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
      if !@line_dash.enabled || @stroke_width == 0
        "line_dash=nil"
      else
        "line_dash=(#{@line_dash.values.join(",")}, offset: #{@line_dash.offset})"
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

  struct State
    include ShapeProperties
    include TextProperties

    property size = Size.new, debug = false

    def initialize(w, h)
      @size.width = w
      @size.height = h
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

    private def draw_on_default_surface(element)
      element.draw(@default_cairo_ctx)
    end

    private def add_shape_properties(ele)
      ele.fill = @fill
      ele.stroke = @stroke
      ele.stroke_width = @stroke_width
      ele.no_fill = @no_fill
      ele.line_dash = @line_dash
      ele.line_cap = @line_cap
      ele.line_join = @line_join
      ele.font = @font
      ele.line_height = @line_height
      ele.align = @align
      ele.hyphenation = @hyphenation
      ele.hyphen_char = @hyphen_char
      @elements << ele

      # Return the element index
      @elements.size - 1
    end

    # Save Context state
    # ```
    # ctx.save_state
    # ctx.fill 0, 0, 1
    # ```
    def save_state
      @saved_context.fill = @fill
      @saved_context.stroke = @stroke
      @saved_context.stroke_width = @stroke_width
      @saved_context.no_fill = @no_fill
      @saved_context.line_dash = @line_dash
      @saved_context.line_cap = @line_cap
      @saved_context.line_join = @line_join
      @saved_context.font = @font
      @saved_context.line_height = @line_height
      @saved_context.align = @align
      @saved_context.hyphenation = @hyphenation
      @saved_context.hyphen_char = @hyphen_char
    end

    # Restore Context state
    # ```
    # ctx.restore_state
    # ```
    def restore_state
      @fill = @saved_context.fill
      @stroke = @saved_context.stroke
      @stroke_width = @saved_context.stroke_width
      @no_fill = @saved_context.no_fill
      @line_dash = @saved_context.line_dash
      @line_cap = @saved_context.line_cap
      @line_join = @saved_context.line_join
      @font = @saved_context.font
      @line_height = @saved_context.line_height
      @align = @saved_context.align
      @hyphenation = @saved_context.hyphenation
      @hyphen_char = @saved_context.hyphen_char
    end

    # Use Saved state as block that applies save_state and
    # restore_state automatically.
    # ```
    # ctx.fill 1, 0, 0
    # ctx.saved_state do
    #   ctx.fill 0, 0, 1
    #   # Blue rect
    #   ctx.rect 100, 100, 200, 200
    # end
    # # Red Rect
    # ctx.rect 200, 200, 200, 200
    # ```
    def saved_state(&block)
      save_state
      block.call
      restore_state
    end
  end
end
