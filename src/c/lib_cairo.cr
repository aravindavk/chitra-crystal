@[Link("cairo")]
lib LibCairo
  alias PCairoT = Void*
  alias PSurfaceT = Void*

  enum StatusT
    Success = 0

    NoMemory
    InvalidRestore
    InvalidPopGroup
    NoCurrentPoint
    InvalidMatrix
    InvalidStatus
    NullPointer
    InvalidString
    InvalidPathData
    ReadError
    WriteError
    SurfaceFinished
    SurfaceTypeMismatch
    PatternTypeMismatch
    InvalidContent
    InvalidFormat
    InvalidVisual
    FileNotFound
    InvalidDash
    InvalidDscComment
    InvalidIndex
    ClipNotRepresentable
    TempFileError
    InvalidStride
    FontTypeMismatch
    UserFontImmutable
    UserFontError
    NegativeCount
    InvalidClusters
    InvalidSlant
    InvalidWeight
    InvalidSize
    UserFontNotImplemented
    DeviceTypeMismatch
    DeviceError
    InvalidMeshConstruction
    DeviceFinished
    Jbig2GlobalMissing
    PngError
    FreetypeError
    Win32GdiError
    TagError

    LastStatus
  end

  enum FormatT
    Invalid   = -1
    ARGB32    =  0
    RGB24     =  1
    A8        =  2
    A1        =  3
    RGB16_565 =  4
    RGB30     =  5
  end

  enum OperatorT
    Clear
    Source
    Over # Default
    In
    Out
    Atop
    Dest
    DestOver
    DestIn
    DestOut
    DestAtop
    Xor
    Add
    Saturate
    Multiply
    Screen
    Overlay
    Darken
    Lighten
    ColorDodge
    ColorBurn
    HardLight
    SoftLight
    Difference
    Exclusion
    HslHue
    HslSaturation
    HslColor
    HslLuminosity
  end

  enum AntialiasT
    Default
    None
    Gray
    Subpixel
    Fast
    Good
    Best
  end

  enum FillRuleT
    Winding
    EvenOdd
  end

  enum LineCapT
    Butt
    Round
    Square
  end

  enum LineJoinT
    Miter
    Round
    Bevel
  end
  enum SurfaceTypeT
    Image
    Pdf
    Ps
    XLib
    Xcb
    Glitz
    Quartz
    Win32
    BeOS
    DirectFB
    Svg
    OS2
    Win32Printing
    QuartzImage
    Script
    Qt
    Recording
    VG
    GL
    DRM
    Tee
    XML
    Skia
    Subsurface
    COGL
  end

  fun cairo_create(target : PSurfaceT) : PCairoT
  fun cairo_reference(cr : PCairoT) : PCairoT
  fun cairo_destroy(cr : PCairoT) : Void
  fun cairo_get_reference_count(cr : PCairoT) : UInt32
  fun cairo_save(cr : PCairoT) : Void
  fun cairo_restore(cr : PCairoT) : Void
  fun cairo_push_group(cr : PCairoT) : Void
  fun cairo_pop_group_to_source(cr : PCairoT) : PCairoT
  fun cairo_set_operator(cr : PCairoT, op : OperatorT) : Void
  fun cairo_set_source_rgb(cr : PCairoT, red : Float64, green : Float64, blue : Float64) : Void
  fun cairo_show_page(cr : PCairoT) : Void
  fun cairo_set_source_rgba(cr : PCairoT, red : Float64, green : Float64, blue : Float64, alpha : Float64) : Void
  fun cairo_set_source_surface(cr : PCairoT, surface : PSurfaceT, x : Float64, y : Float64) : Void
  fun cairo_set_antialias(cr : PCairoT, antialias : AntialiasT) : Void
  fun cairo_set_fill_rule(cr : PCairoT, fill_rule : FillRuleT) : Void
  fun cairo_set_line_width(cr : PCairoT, width : Float64) : Void
  fun cairo_set_line_cap(cr : PCairoT, line_cap : LineCapT) : Void
  fun cairo_set_line_join(cr : PCairoT, line_join : LineJoinT) : Void
  fun cairo_set_dash(cr : PCairoT, dashes : Float64*, num_dashes : Int32, offset : Float64) : Void
  fun cairo_set_miter_limit(cr : PCairoT, limit : Float64) : Void
  fun cairo_translate(cr : PCairoT, tx : Float64, ty : Float64) : Void
  fun cairo_scale(cr : PCairoT, sx : Float64, sy : Float64) : Void
  fun cairo_rotate(cr : PCairoT, angle : Float64) : Void
  fun cairo_move_to(cr : PCairoT, x : Float64, y : Float64) : Void
  fun cairo_line_to(cr : PCairoT, x : Float64, y : Float64) : Void
  fun cairo_curve_to(cr : PCairoT, x1 : Float64, y1 : Float64, x2 : Float64, y2 : Float64, x3 : Float64, y3 : Float64) : Void
  fun cairo_arc(cr : PCairoT, xc : Float64, yc : Float64, radius : Float64, angle1 : Float64, angle2 : Float64) : Void
  fun cairo_rectangle(cr : PCairoT, x : Float64, y : Float64, width : Float64, height : Float64) : Void
  fun cairo_close_path(cr : PCairoT) : Void
  fun cairo_path_extents(cr : PCairoT, x1 : Float64*, y1 : Float64*, x2 : Float64*, y2 : Float64*) : Void
  fun cairo_paint(cr : PCairoT) : Void
  fun cairo_paint_with_alpha(cr : PCairoT, alpha : Float64) : Void
  fun cairo_stroke(cr : PCairoT) : Void
  fun cairo_stroke_preserve(cr : PCairoT) : Void
  fun cairo_fill(cr : PCairoT) : Void
  fun cairo_fill_preserve(cr : PCairoT) : Void
  fun cairo_get_operator(cr : PCairoT) : OperatorT
  fun cairo_get_antialias(cr : PCairoT) : AntialiasT
  fun cairo_get_fill_rule(cr : PCairoT) : FillRuleT
  fun cairo_get_line_width(cr : PCairoT) : Float64
  fun cairo_get_line_cap(cr : PCairoT) : LineCapT
  fun cairo_get_line_join(cr : PCairoT) : LineJoinT
  fun cairo_get_miter_limit(cr : PCairoT) : Float64
  fun cairo_get_dash_count(cr : PCairoT) : Int32
  fun cairo_get_dash(cr : PCairoT, dashes : Float64*, offset : Float64*) : Void
  fun cairo_svg_surface_create(filename : UInt8*, width_in_points : Float64, height_in_points : Float64) : PSurfaceT
  fun cairo_pdf_surface_create(filename : UInt8*, width_in_points : Float64, height_in_points : Float64) : PSurfaceT
  fun cairo_surface_reference(surface : PSurfaceT) : PSurfaceT
  fun cairo_surface_finish(surface : PSurfaceT) : Void
  fun cairo_surface_destroy(surface : PSurfaceT) : Void
  fun cairo_surface_write_to_png(surface : PSurfaceT, filename : UInt8*) : StatusT
  fun cairo_surface_flush(surface : PSurfaceT) : Void
  fun cairo_surface_copy_page(surface : PSurfaceT) : Void
  fun cairo_surface_show_page(surface : PSurfaceT) : Void
  fun cairo_image_surface_create(format : FormatT, width : Int32, height : Int32) : PSurfaceT
  fun cairo_image_surface_get_format(surface : PSurfaceT) : FormatT
  fun cairo_image_surface_get_width(surface : PSurfaceT) : Int32
  fun cairo_image_surface_get_height(surface : PSurfaceT) : Int32
  fun cairo_image_surface_create_from_png(filename : UInt8*) : PSurfaceT
end
