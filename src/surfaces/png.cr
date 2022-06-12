module Chitra
  struct PngSurface < Surface
    getter surface

    def initialize(@output_file, w, h)
      @surface = LibCairo.cairo_image_surface_create(LibCairo::FormatT::ARGB32, w, h)
    end

    def draw
      LibCairo.cairo_surface_write_to_png(@surface, @output_file.to_unsafe)
      LibCairo.cairo_surface_finish(@surface)
    end
  end
end
