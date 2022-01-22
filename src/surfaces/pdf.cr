module Chitra
  struct PdfSurface < Surface
    getter surface

    def initialize(@output_file, w, h)
      @surface = Cairo::PdfSurface.new @output_file, w, h
    end

    def draw
      @surface.finish
    end
  end
end
