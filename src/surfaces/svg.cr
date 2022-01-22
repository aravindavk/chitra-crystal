module Chitra
  struct SvgSurface < Surface
    getter surface

    def initialize(@output_file, w, h)
      @surface = Cairo::SvgSurface.new @output_file, w, h
    end

    def draw
      @surface.finish
    end
  end
end
