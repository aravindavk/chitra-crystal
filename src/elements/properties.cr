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

    # Set Stroke/Line width. Default value is 1.
    # ```
    # ctx.stroke_width 10
    # ```
    def stroke_width(value)
      @stroke_width = value
    end
  end
end
