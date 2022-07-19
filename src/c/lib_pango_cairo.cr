{% begin %}
  @[Link(ldflags: {{ `pkg-config --libs pangocairo`.stringify.chomp }})]
{% end %}

lib LibPangoCairo
  type Cairo = Void
  type PangoCtx = Void
  type PangoFontDescription = Void
  type PangoLayout = Void
  type CairoFontOptions = Void
  SCALE = 1024
  enum EllipsizeMode
    None
    Start
    Middle
    End
  end

  enum WrapMode
    Word
    Char
    WordChar
  end

  enum Alignment
    Left
    Center
    Right
  end

  fun pango_cairo_create_layout(ctx : Void*) : PangoLayout*
  fun pango_layout_set_text(layout : PangoLayout*, text : UInt8*, length : Int32)
  fun pango_layout_set_markup(layout : PangoLayout*, text : UInt8*, length : Int32)
  fun pango_layout_set_width(layout : PangoLayout*, w : Int32)
  fun pango_layout_set_height(layout : PangoLayout*, w : Int32)
  fun pango_layout_get_line_spacing(layout : PangoLayout*) : Float32
  fun pango_layout_set_line_spacing(layout : PangoLayout*, factor : Float32) : Void
  fun pango_layout_set_wrap(layout : PangoLayout*, mode : WrapMode) : Void
  fun pango_layout_set_justify(layout : PangoLayout*, justify : Bool) : Void
  fun pango_layout_set_alignment(layout : PangoLayout*, align : Alignment) : Void
  fun pango_font_description_from_string(font : UInt8*) : PangoFontDescription*
  fun pango_layout_set_font_description(layout : PangoLayout*, desc : PangoFontDescription*) : Void
  fun pango_font_description_free(font : PangoFontDescription*) : Void
  fun pango_layout_get_size(layout : PangoLayout*, width : UInt32*, height : UInt32*) : Void
  fun pango_cairo_show_layout(ctx : Void*, layout : PangoLayout*) : Void
  fun pango_cairo_update_layout(ctx : Void*, layout : PangoLayout*) : Void
  fun pango_cairo_layout_path(ctx : Void*, layout : PangoLayout*) : Void
  fun pango_cairo_context_set_font_options(pctx : PangoCtx*, opts : CairoFontOptions*)
  fun pango_layout_set_ellipsize(layout : PangoLayout*, mode : EllipsizeMode)
end
