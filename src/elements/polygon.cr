module Chitra
  struct Polygon < Element
    include ShapeProperties

    # :nodoc:
    def initialize(@points : Array(Array(Float64)), @close = true)
    end

    # :nodoc:
    def draw(cairo_ctx)
      cairo_ctx.move_to(@points[0][0], @points[0][1])
      @points[1..].each do |p|
        cairo_ctx.line_to(p[0], p[1])
      end
      cairo_ctx.close_path if @close
      draw_shape_properties(cairo_ctx)
    end

    # :nodoc:
    def to_s
      debug_text "polygon(#{@points.join(",")}, close=#{@close})"
    end
  end

  class Context
    # Draw polygon shape. By default closes the path
    # ```
    # ctx = Chitra.new
    # x y w h
    # ctx.polygon 50, 450, 50, 50, 450, 50, 100, 100, close: true
    # ```
    def polygon(*points, close = true)
      values = coord_pairs_validate(points)
      p = Polygon.new(values, close)
      idx = add_shape_properties(p)

      draw_on_default_surface(@elements[idx])
    end

    # Draw polygon shape. By default closes the path
    # ```
    # ctx = Chitra.new
    # x y w h
    # ctx.polygon [50, 450, 50, 50, 450, 50, 100, 100], close: true
    # ```
    def polygon(points : Array(Float64), close = true)
      values = coord_pairs_validate(points)
      p = Polygon.new(values, close)
      idx = add_shape_properties(p)

      draw_on_default_surface(@elements[idx])
    end
  end
end
