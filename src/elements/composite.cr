module Chitra
  struct GroupStart < Element
    # :nodoc:
    def initialize
    end

    # :nodoc:
    def draw(cairo_ctx)
      LibCairo.cairo_push_group(cairo_ctx)
    end

    # :nodoc:
    def to_s
      "group_start"
    end
  end

  struct Composite < Element
    # :nodoc:
    def initialize(operator : String)
      @operator = LibCairo::OperatorT.parse(operator.camelcase)
    end

    # :nodoc:
    def draw(cairo_ctx)
      LibCairo.cairo_set_operator(cairo_ctx, @operator)
    end

    # :nodoc:
    def to_s
      "composite(#{@operator})"
    end
  end

  struct GroupEnd < Element
    # :nodoc:
    def initialize
      @operator = LibCairo::OperatorT::Over
    end

    # :nodoc:
    def draw(cairo_ctx)
      LibCairo.cairo_pop_group_to_source(cairo_ctx)
      LibCairo.cairo_paint(cairo_ctx)
      LibCairo.cairo_set_operator(cairo_ctx, @operator)
    end

    # :nodoc:
    def to_s
      "group_end"
    end
  end

  class Context
    # Start a Group
    # ```
    # ctx.group_start
    # ctx.rect 10, 10, 100, 100
    # ctx.composite "in"
    # ctx.rect 50, 50, 100, 100
    # ctx.group_end
    # ```
    def group_start
      c = GroupStart.new
      @elements << c

      draw_on_default_surface(c)
    end

    # Apply Composite
    # ```
    # ctx.group_start
    # ctx.rect 10, 10, 100, 100
    # ctx.composite "in"
    # ctx.rect 50, 50, 100, 100
    # ctx.group_end
    # ```
    # Other available Composite options are:
    # Clear, Source, Over, In, Out, Atop, Dest, DestOver,
    # DestIn, DestOut, DestAtop, Xor, Add, Saturate,
    # Multiply, Screen, Overlay, Darken, Lighten, ColorDodge,
    # ColorBurn, HardLight, SoftLight, Difference, Exclusion,
    # HslHue, HslSaturation, HslColor, HslLuminosity
    #
    # Refer https://www.cairographics.org/operators/
    # for more details.
    def composite(op : String)
      c = Composite.new(op)
      @elements << c

      draw_on_default_surface(c)
    end

    # End a Group
    # ```
    # ctx.group_start
    # ctx.rect 10, 10, 100, 100
    # ctx.composite "in"
    # ctx.rect 50, 50, 100, 100
    # ctx.group_end
    # ```
    def group_end
      c = GroupEnd.new
      @elements << c

      draw_on_default_surface(c)
    end

    # Grouped code run as block
    # ```
    # ctx.grouped do
    #   ctx.rect 10, 10, 100, 100
    #   ctx.composite "In"
    #   ctx.rect 50, 50, 100, 100
    # end
    # ```
    def grouped(&block)
      group_start
      block.call
      group_end
    end
  end
end
