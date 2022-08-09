require "../c/lib_pango_cairo"

require "./markup_tokens"

module Chitra
  RAINBOW_COLORS = [
    "#9400D3", # Violet
    "#4B0082", # Indigo
    "#0000FF", # Blue
    "#00FF00", # Green
    "#FFFF00", # Yellow
    "#FF7F00", # Orange
    "#FF0000", # Red
  ]

  struct Markup < Element
    include ShapeProperties
    include TextProperties

    # :nodoc:
    def initialize(@txt : String, @x : Float64, @y : Float64)
    end

    # :nodoc:
    def draw(cairo_ctx)
      # Set fill color before Pango drawing to
      # avoid using previously used color for fill
      if @no_fill
        LibCairo.cairo_set_source_rgba cairo_ctx, 0, 0, 0, 0
      else
        LibCairo.cairo_set_source_rgba cairo_ctx, @fill.r, @fill.g, @fill.b, @fill.a
      end

      LibCairo.cairo_set_antialias(cairo_ctx, LibCairo::AntialiasT::Best)
      LibCairo.cairo_move_to(cairo_ctx, @x, @y)
      layout = LibPangoCairo.pango_cairo_create_layout(cairo_ctx)
      LibPangoCairo.pango_layout_set_markup(layout, @txt, -1)
      desc = LibPangoCairo.pango_font_description_from_string("#{@font.family},  #{@font.slant} #{@font.weight} #{@font.height}px")
      LibPangoCairo.pango_layout_set_font_description(layout, desc)
      LibPangoCairo.pango_font_description_free(desc)
      LibPangoCairo.pango_cairo_update_layout(cairo_ctx, layout)
      LibPangoCairo.pango_cairo_show_layout(cairo_ctx, layout)
      LibPangoCairo.pango_cairo_layout_path(cairo_ctx, layout)
      LibCairo.cairo_new_path(cairo_ctx)
    end

    # :nodoc:
    def to_s
      debug_text "markup(#{@txt[0..6]}#{@txt.size > 7 ? ".." : ""}, #{@x}, #{@y})"
    end
  end

  struct MarkupBox < Element
    include ShapeProperties
    include TextProperties

    # :nodoc:
    def initialize(@txt : String, @x : Float64, @y : Float64, @w : Float64, @h : Float64)
    end

    # :nodoc:
    def draw(cairo_ctx)
      # Set fill color before Pango drawing to
      # avoid using previously used color for fill
      if @no_fill
        LibCairo.cairo_set_source_rgba cairo_ctx, 0, 0, 0, 0
      else
        LibCairo.cairo_set_source_rgba cairo_ctx, @fill.r, @fill.g, @fill.b, @fill.a
      end

      LibCairo.cairo_move_to(cairo_ctx, @x, @y)
      LibCairo.cairo_set_antialias cairo_ctx, LibCairo::AntialiasT::Best
      layout = LibPangoCairo.pango_cairo_create_layout(cairo_ctx)
      LibPangoCairo.pango_layout_set_width(layout, @w*LibPangoCairo::SCALE)
      if @h > 0
        LibPangoCairo.pango_layout_set_height(layout, @h*LibPangoCairo::SCALE)
      end
      desc = LibPangoCairo.pango_font_description_from_string("#{@font.family}, #{@font.slant} #{@font.weight} #{@font.height}px")
      LibPangoCairo.pango_layout_set_font_description(layout, desc)
      LibPangoCairo.pango_font_description_free(desc)
      LibPangoCairo.pango_layout_set_line_spacing(layout, @line_height)

      if @hyphenation
        LibPangoCairo.pango_layout_set_wrap(layout, LibPangoCairo::WrapMode::Char)
      else
        case @align
        when "justify" then LibPangoCairo.pango_layout_set_justify(layout, true)
        when "center"  then LibPangoCairo.pango_layout_set_alignment(layout, LibPangoCairo::Alignment::Center)
        when "right"   then LibPangoCairo.pango_layout_set_alignment(layout, LibPangoCairo::Alignment::Right)
        else
          LibPangoCairo.pango_layout_set_alignment(layout, LibPangoCairo::Alignment::Left)
        end
      end

      txt = ""
      overflow = false
      overflow_text = ""

      if @h > 0
        overflow_text = ""
        MarkupTokens.new(@txt).each do |t, rest|
          LibPangoCairo.pango_layout_set_markup(layout, t.rstrip, -1)
          LibPangoCairo.pango_layout_get_size(layout, out w, out h)

          if h/LibPangoCairo::SCALE > @h
            overflow = true
            break
          end

          txt = t
          overflow_text = rest
        end
      else
        txt = @txt
      end

      unless overflow
        overflow_text = ""
      end

      LibPangoCairo.pango_layout_set_markup(layout, txt, -1)
      LibPangoCairo.pango_layout_get_size(layout, out w, out h)

      LibPangoCairo.pango_cairo_update_layout(cairo_ctx, layout)
      LibPangoCairo.pango_cairo_show_layout(cairo_ctx, layout)
      LibPangoCairo.pango_cairo_layout_path(cairo_ctx, layout)
      LibCairo.cairo_new_path(cairo_ctx)

      {overflow_text, w/LibPangoCairo::SCALE, h/LibPangoCairo::SCALE}
    end

    # :nodoc:
    def to_s
      debug_text "markup_box(#{@txt[0..6]}#{@txt.size > 7 ? ".." : ""}, #{@x}, #{@y}, #{@w}, #{@h})"
    end
  end

  class Context
    # Draw text for given x and y values.
    # ```
    # markup "Hello <b>World</b>", 100, 100
    # ```
    def markup(txt, x, y)
      t = Markup.new(txt, x, y)
      idx = add_shape_properties(t)
      draw_on_default_surface(@elements[idx])
    end

    def markup_box(txt, x, y, w, h = 0.0)
      t = MarkupBox.new(txt, x, y, w, h)
      idx = add_shape_properties(t)

      overflow = draw_on_default_surface(@elements[idx])
      overflow.is_a?(Tuple(String, Float64, Float64)) ? overflow : {"", w, h}
    end

    private def rainbow_text(txt)
      col_idx = 0
      out_txt = ""
      txt.each do |t|
        out_txt += "<span color=\"#{RAINBOW_COLORS[col_idx]}\">#{t}</span>"
        if col_idx == 6
          col_idx = 0
        else
          col_idx += 1
        end
      end

      out_txt
    end

    def rainbow(txt : Array(String), x, y)
      markup(rainbow_text(txt), x, y)
    end

    def rainbow_box(txt : Array(String), x, y, w, h = 0.0)
      markup_box(rainbow_text(txt), x, y, w, h)
    end
  end
end
