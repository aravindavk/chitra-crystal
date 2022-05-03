module Chitra
  struct NewPage < Element
    # :nodoc:
    def initialize
    end

    # :nodoc:
    def draw(cairo_ctx)
      cairo_ctx.show_page
    end

    # :nodoc:
    def to_s
      "new_page"
    end
  end

  class Context
    # Creates a new page.
    # ```
    # ctx = Chitra.new 200
    # ctx.scale 2
    # ctx.rect 40, 40, 40, 40
    # ctx.new_page
    # ctx.rect 40, 40, 40, 40
    # ```
    def new_page
      p = NewPage.new
      @elements << p
      draw_on_default_surface(p)
    end
  end
end
