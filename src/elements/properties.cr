module Chitra
  class Context
    # Set fill color. Color values are
    # between 0 and 1. Default color is Black/RGBA(0, 0, 0, 1)
    # ```
    # #        r  g  b
    # ctx.fill 0, 0, 1
    #
    # # Fill with 50% opacity
    # r g b a
    # ctx.fill 0, 0, 1, 0.5
    # ```
    def fill(r, g, b, a = 1.0)
      color_validate(r, g, b, a)
      @no_fill = false
      @fill.r = r.to_f64
      @fill.g = g.to_f64
      @fill.b = b.to_f64
      @fill.a = a.to_f64
    end

    # Set fill color. Color values are
    # between 0 and 1. Default color is Black/RGBA(0, 0, 0, 1)
    # ```
    # # Black color
    # #        gray
    # ctx.fill 0
    #
    # # White color
    # ctx.fill 1
    #
    # # Fill black with 50% opacity
    # gray a
    # ctx.fill 0, 0.5
    # ```
    def fill(gray, a = 1.0)
      fill(gray, gray, gray, a)
    end

    # Set fill color in hex format.
    # Default color is Black/Hex(#000000)
    # ```
    # # Black color
    # #        hex_color
    # ctx.fill "#000000"
    #
    # # White color
    # ctx.fill "#ffffff"
    #
    # # Fill black with 50% opacity
    # # 00 - 0% and FF - 100% opacity
    # gray a
    # ctx.fill "#00000080"
    # ```
    def fill(hexcol : String)
      @fill.r, @fill.g, @fill.b, @fill.a = *Color.hex2rgb(hexcol)
    end

    # Set fill opacity. Opacity values are
    # between 0 and 1.
    # ```
    # # 50% Opacity
    # #                opacity
    # ctx.fill_opacity 0.5
    # ```
    def fill_opacity(a)
      fill(@fill.r, @fill.g, @fill.b, a)
    end

    # Disable fill
    # ```
    # ctx.no_fill
    # ```
    def no_fill
      @no_fill = true
    end

    # Set Stroke color(Gray scale). Color values are
    # between 0 and 1. Default color is Black/RGBA(0, 0, 0, 1)
    # ```
    # #          r  g  b
    # ctx.stroke 0, 0, 1
    #
    # # Stroke with 50% opacity
    # r g b a
    # ctx.stroke 0, 0, 1, 0.5
    # ```
    def stroke(r, g, b, a = 1.0)
      color_validate(r, g, b, a)
      @stroke.r = r.to_f64
      @stroke.g = g.to_f64
      @stroke.b = b.to_f64
      @stroke.a = a.to_f64
    end

    # Set stroke/line color(Gray scale). Color values are
    # between 0 and 1. Default color is Black/RGBA(0, 0, 0, 1)
    # ```
    # # Black color
    # #          gray
    # ctx.stroke 0
    #
    # # White color
    # ctx.stroke 1
    #
    # # Fill black with 50% opacity
    # gray a
    # ctx.stroke 0, 0.5
    # ```
    def stroke(gray, a = 1.0)
      stroke(gray, gray, gray, a)
    end

    # Set Stroke color in hex format.
    # Default color is Black/Hex(#000000)
    # ```
    # # Black color
    # #          hex_color
    # ctx.stroke "#000000"
    #
    # # White color
    # ctx.stroke "#ffffff"
    #
    # # Fill black with 50% opacity
    # # 00 - 0% and FF - 100% opacity
    # ctx.stroke "#00000080"
    # ```
    def stroke(hexcol : String)
      @stroke.r, @stroke.g, @stroke.b, @stroke.a = *Color.hex2rgb(hexcol)
    end

    # Set stroke opacity. Opacity values are
    # between 0 and 1.
    # ```
    # # 50% Opacity
    # #                  opacity
    # ctx.stroke_opacity 0.5
    # ```
    def stroke_opacity(a)
      stroke(@stroke.r, @stroke.g, @stroke.b, a)
    end

    # Set Stroke/Line width. Default value is 1.
    # ```
    # ctx.stroke_width 10
    # ```
    def stroke_width(value)
      @stroke_width = value
    end

    # Disable Stroke.
    # ```
    # ctx.stroke_width 0
    # # OR
    # ctx.no_stroke
    # ```
    def no_stroke
      @stroke_width = 0
    end

    # Set line dash pattern. `line_dash 0` disables
    # the dash.Symmetric dash pattern with one value
    # to this function.
    # ```
    # ctx.line_dash 2
    # ```
    # Asymmetric pattern
    # ```
    # ctx.line_dash 2, 4, 10
    # ```
    # To set the offset value to start the pattern
    # ```
    # ctx.line_dash 2, 4, 10, offset: 1
    # ```
    def line_dash(*values, offset = 0)
      line_dash(values, offset: offset)
    end

    # Set line dash pattern. `line_dash 0` disables
    # the dash.Symmetric dash pattern with one value
    # to this function.
    # ```
    # ctx.line_dash [2]
    # ```
    # Asymmetric pattern
    # ```
    # ctx.line_dash [2, 4, 10]
    # ```
    # To set the offset value to start the pattern
    # ```
    # ctx.line_dash [2, 4, 10], offset: 1
    # ```
    def line_dash(values : Array(Int32), offset = 0)
      if values.size == 1 && values[0] == 0
        @line_dash.enabled = false
        return
      elsif values.size > 0
        @line_dash.enabled = true
      end

      @line_dash.values = (values.map &.to_f64).to_a
      @line_dash.offset = offset.to_f64
    end

    # Set Line cap style
    # Allowed values are butt, round and square.
    # Default value is butt.
    # ```
    # ctx.line_cap "round"
    # ctx.line 100, 100, 500, 100
    # ```
    def line_cap(value)
      parsed = LibCairo::LineCapT.parse?(value)
      if parsed.nil?
        raise Exception.new "Invalid line_cap value"
      else
        @line_cap = parsed
      end
    end

    # Set Line join style
    # Possible values are: miter, round, bevel.
    # Default value is miter.
    # ```
    # ctx.stroke_width 14
    # ctx.line_join "round"
    # ctx.rect 100, 100, 500, 500
    # ```
    def line_join(value)
      parsed = LibCairo::LineJoinT.parse?(value)
      if parsed.nil?
        raise Exception.new "Invalid line_join value"
      else
        @line_join = parsed
      end
    end

    # Set Font family and size
    # ```
    # ctx.font "Times", 30
    # ```
    def font(font_name, font_size)
      @font.family = font_name
      @font.height = font_size
    end

    # Set Font size
    # ```
    # ctx.font_size 30
    # ```
    def font_size(font_size)
      @font.height = font_size
    end

    # Set Font weight
    # ```
    # ctx.font_weight "Heavy"
    # ```
    def font_weight(wt)
      @font.weight = wt
    end

    # Set Text align for text boxes
    # ```
    # ctx.text_align "center"
    # ```
    def text_align(value)
      @align = value
    end

    # Enable/Disable text hyphenation. Default is disabled
    # ```
    # ctx.hyphenation true
    # ```
    def hyphenation(value)
      @hyphenation = value
    end

    # Set Hyphenation char. Default is -
    # ```
    # ctx.hyphen_char "*"
    # ```
    def hyphen_char(value)
      @hyphen_char = value
    end

    def line_height(value)
      @line_height = value.to_f64
    end
  end
end
