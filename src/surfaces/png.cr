module Chitra
  struct PngSurface < Surface
    getter surface

    def initialize(@output_file, w, h)
      @surface = Cairo::Surface.new(Cairo::Format::ARGB32, w, h)
    end

    def draw
      @surface.write_to_png(@output_file)
      @surface.finish
    end
  end
end
