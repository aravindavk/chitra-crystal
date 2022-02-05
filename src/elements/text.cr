module Chitra
  struct Text < Element
    include ShapeProperties
    include TextProperties

    # :nodoc:
    def initialize(@txt : String, @x : Float64, @y : Float64)
    end

    # :nodoc:
    def draw(cairo_ctx)
      cairo_ctx.select_font_face(@font.family, @font.slant, @font.weight)
      cairo_ctx.font_size = @font.height
      cairo_ctx.move_to(@x, @y)
      cairo_ctx.text_path(@txt)
      draw_shape_properties(cairo_ctx)
    end

    # :nodoc:
    def to_s
      debug_text "text(#{@txt[0..6]}#{@txt.size > 7 ? ".." : ""}, #{@x}, #{@y})"
    end
  end

  struct TextBox < Element
    include ShapeProperties
    include TextProperties

    # :nodoc:
    def initialize(@txt : String, @x : Float64, @y : Float64, @w : Float64, @h : Float64)
    end

    private def text_size(cairo_ctx, txt)
      data = cairo_ctx.text_extents(txt)
      {data.width, data.height}
    end

    private def align_x(w, text_w, align)
      # TODO: align: justify
      case align
      when "right"  then w - text_w
      when "center" then (w - text_w)/2
      else
        0
      end
    end

    # Important function that splits the given string into
    # multiple lines when the rendered text is wider than the
    # available width.
    private def split_lines(cairo_ctx)
      line = ""
      unconfirmed = ""
      lines = [] of String
      @txt.each_grapheme do |v|
        letter = v.to_s
        text_w, _text_h = text_size(cairo_ctx, line + unconfirmed + letter)
        if text_w > @w
          if letter == " " || letter == "\n"
            lines << (line + unconfirmed).strip
            unconfirmed = ""
          else
            if @hyphenation
              lines << (line + unconfirmed).strip + @hyphen_char
              line = letter
            else
              lines << line.strip
              # FIX: If initial width is more than line width available. What to do?
              line = unconfirmed + letter
            end
            unconfirmed = ""
          end
        else
          if letter == " " || letter == "\n"
            line += unconfirmed + letter
            unconfirmed = ""
          else
            unconfirmed += letter
          end
        end
      end

      remaining = (line + unconfirmed).strip

      if remaining != ""
        lines << remaining
      end

      y = @y
      lines.map do |l|
        text_w, _text_h = text_size(cairo_ctx, l)
        x = @x + align_x(@w, text_w, @align)
        y += @line_height * @font.height
        in_box = y > (@y + @h) ? false : true
        {txt: l, x: x, y: y, in_box: in_box}
      end
    end

    # :nodoc:
    def draw(cairo_ctx)
      cairo_ctx.select_font_face(@font.family, @font.slant, @font.weight)
      cairo_ctx.font_size = @font.height

      lines = split_lines(cairo_ctx)
      lines.each do |line|
        # TODO: How to return overflow text back to caller?
        break unless line[:in_box]

        cairo_ctx.move_to(line[:x], line[:y])
        cairo_ctx.text_path(line[:txt])
        draw_shape_properties(cairo_ctx)
      end
    end

    # :nodoc:
    def to_s
      debug_text "text_box(#{@txt[0..6]}#{@txt.size > 7 ? ".." : ""}, #{@x}, #{@y}, #{@w}, #{@h})"
    end
  end

  class Context
    # Draw text for given x and y values.
    # ```
    # text "Hello World", 100, 100
    # ```
    def text(txt, x, y)
      t = Text.new(txt, x, y)
      add_shape_properties(t)
    end

    def text_box(txt, x, y, w, h)
      t = TextBox.new(txt, x, y, w, h)
      add_shape_properties(t)
    end
  end
end
