require "./c/lib_cairo"

# Reopen number struct and add conversion utilities
struct Number
  def inch
    # 72 pixels per inch
    self * 72 * (Chitra.resolution/72)
  end

  def cm
    (self / 2.54).inch
  end

  def mm
    (self / 10).cm
  end
end

module Chitra
  @@resolution = 72 # ppi

  def self.resolution
    @@resolution
  end

  # Set resolution
  # Default value is 72 ppi
  # ```
  # Chitra.resolution 300
  # ctx = Chitra.new 297.mm, 210.mm
  # ctx.rect 10.mm, 10.mm, 500
  # ```
  def self.resolution(val)
    @@resolution = val
  end

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

    def reset_text_properties
      @font = Font.new
      @line_height = 1.5
      @align = "left"
      @hyphenation = false
      @hyphen_char = "-"
    end
  end

  module ShapeProperties
    property fill = Color.new,
      stroke = Color.new,
      stroke_width = 1,
      no_fill = false,
      line_dash = LineDash.new,
      line_cap = LibCairo::LineCapT::Butt,
      line_join = LibCairo::LineJoinT::Miter

    def reset_shape_properties
      @fill = Color.new
      @stroke = Color.new
      @stroke_width = 1
      @no_fill = false
      @line_dash = LineDash.new
      @line_cap = LibCairo::LineCapT::Butt
      @line_join = LibCairo::LineJoinT::Miter
    end
  end

  abstract struct Element
    include ShapeProperties
    include TextProperties

    def draw_shape_properties(cairo_ctx)
      if @no_fill
        LibCairo.cairo_set_source_rgba cairo_ctx, 0, 0, 0, 0
      else
        LibCairo.cairo_set_source_rgba cairo_ctx, @fill.r, @fill.g, @fill.b, @fill.a
      end

      if @stroke_width > 0
        LibCairo.cairo_fill_preserve(cairo_ctx)
        LibCairo.cairo_set_line_width cairo_ctx, @stroke_width
        if @line_dash.enabled
          LibCairo.cairo_set_dash(cairo_ctx, @line_dash.values.to_unsafe, @line_dash.values.size, @line_dash.offset)
        else
          LibCairo.cairo_set_dash(cairo_ctx, [] of Float64, 0, 0)
        end
        LibCairo.cairo_set_line_cap(cairo_ctx, @line_cap)
        LibCairo.cairo_set_line_join(cairo_ctx, @line_join)
        LibCairo.cairo_set_source_rgba(cairo_ctx, @stroke.r, @stroke.g, @stroke.b, @stroke.a)
        LibCairo.cairo_stroke(cairo_ctx)
      else
        LibCairo.cairo_fill(cairo_ctx)
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

    def self.hex2rgb(hexcol)
      h = hexcol.lstrip("#")
      {
        h[0...2].to_i(16)/256,
        h[2...4].to_i(16)/256,
        h[4...6].to_i(16)/256,
        h.size == 8 ? h[6...8].to_i(16)/256 : 1.0,
      }
    end
  end

  struct Size
    property width = 700, height = 700

    def initialize
    end
  end

  class State
    include ShapeProperties
    include TextProperties

    property size = Size.new, debug = false,
      enabled = false,
      transformations = [] of Element

    def initialize(w, h)
      @size.width = w
      @size.height = h
    end

    def add_transformation(ele : Element)
      @transformations << ele
    end

    def reset_transformations
      @transformations = [] of Element
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
    def save_state(saved_context)
      saved_context.enabled = true
      saved_context.fill = @fill
      saved_context.stroke = @stroke
      saved_context.stroke_width = @stroke_width
      saved_context.no_fill = @no_fill
      saved_context.line_dash = @line_dash
      saved_context.line_cap = @line_cap
      saved_context.line_join = @line_join
      saved_context.font = @font
      saved_context.line_height = @line_height
      saved_context.align = @align
      saved_context.hyphenation = @hyphenation
      saved_context.hyphen_char = @hyphen_char
    end

    # Restore Context state
    # ```
    # ctx.restore_state
    # ```
    def restore_state(saved_context)
      @fill = saved_context.fill
      @stroke = saved_context.stroke
      @stroke_width = saved_context.stroke_width
      @no_fill = saved_context.no_fill
      @line_dash = saved_context.line_dash
      @line_cap = saved_context.line_cap
      @line_join = saved_context.line_join
      @font = saved_context.font
      @line_height = saved_context.line_height
      @align = saved_context.align
      @hyphenation = saved_context.hyphenation
      @hyphen_char = saved_context.hyphen_char

      # Reverse the Transformations added during the saved state
      saved_context.transformations.reverse_each do |ele|
        case ele
        when Translate
          t = Translate.new -ele.@x, -ele.@y
          @elements << t
          draw_on_default_surface(t)
        when Scale
          scale_x = ele.@scale_x > 0 ? 1/ele.@scale_x : 0.0
          scale_y = ele.@scale_y > 0 ? 1/ele.@scale_y : 0.0
          s = Scale.new(scale_x, scale_y)
          @elements << s
          draw_on_default_surface(s)
        when Rotate
          r = Rotate.new(-ele.@angle, ele.@center_x, ele.@center_y)
          @elements << r
          draw_on_default_surface(r)
        end
      end
      saved_context.enabled = false
      saved_context.reset_transformations
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
      prev_saved_context = @current_saved_context
      saved_context = State.new(@size.width, @size.height)
      @current_saved_context = saved_context

      save_state(saved_context)
      block.call
      restore_state(saved_context)

      @current_saved_context = prev_saved_context
    end
  end
end
