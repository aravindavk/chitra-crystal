require "json"

require "./chitra"

abstract struct ElementAPI
  include JSON::Serializable

  {% begin %}
    property type = {{ @type.stringify.gsub(/API$/, "").underscore }}
  {% end %}

  abstract def add_to_context(ctx : Chitra::Context)
end

struct SizeAPI < ElementAPI
  property w = 0, h = 0

  def add_to_context(ctx)
    Chitra::Context.new(@w, @h)
  end
end

NO_ARG_FUNCS = %w[enable_debug no_fill new_drawing
  no_stroke new_page]

{% begin %}
  {% for name in NO_ARG_FUNCS %}
    struct {{ name.camelcase.id }}API < ElementAPI
      def add_to_context(ctx)
        ctx.{{name.id}}

        ctx
      end
    end
  {% end %}
{% end %}

struct FillAPI < ElementAPI
  property r = 0, g = 0, b = 0, a = 1, gray = -1.0, hex = ""

  def add_to_context(ctx)
    if @hex != ""
      ctx.fill(@hex)
    elsif @gray > -1
      ctx.fill(@gray, @a)
    else
      ctx.fill(@r, @g, @b, @a)
    end

    ctx
  end
end

struct StrokeAPI < ElementAPI
  property r = 0, g = 0, b = 0, a = 1, gray = -1.0, hex = ""

  def add_to_context(ctx)
    if @hex != ""
      ctx.stroke(@hex)
    elsif @gray > -1
      ctx.stroke(@gray, @a)
    else
      ctx.stroke(@r, @g, @b, @a)
    end

    ctx
  end
end

struct BackgroundAPI < ElementAPI
  property r = 0, g = 0, b = 0, a = 1, gray = -1.0, hex = ""

  def add_to_context(ctx)
    if @hex != ""
      ctx.background(@hex)
    elsif @gray > -1
      ctx.background(@gray, @a)
    else
      ctx.background(@r, @g, @b, @a)
    end

    ctx
  end
end

struct RectAPI < ElementAPI
  property x = 0.0, y = 0.0, w = 0.0, h = 0.0

  def add_to_context(ctx)
    ctx.rect @x, @y, @w, @h

    ctx
  end
end

struct OvalAPI < ElementAPI
  property x = 0.0, y = 0.0, w = 0.0, h = 0.0

  def add_to_context(ctx)
    ctx.oval @x, @y, @w, @h

    ctx
  end
end

struct SaveAPI < ElementAPI
  property path = ""

  def add_to_context(ctx)
    ctx.save @path

    ctx
  end
end

struct StrokeWidthAPI < ElementAPI
  property w = 0

  def add_to_context(ctx)
    ctx.stroke_width @w

    ctx
  end
end

struct FillOpacityAPI < ElementAPI
  property a = 1.0

  def add_to_context(ctx)
    ctx.fill_opacity @a

    ctx
  end
end

struct StrokeOpacityAPI < ElementAPI
  property a = 1.0

  def add_to_context(ctx)
    ctx.stroke_opacity @a

    ctx
  end
end

struct ImageAPI < ElementAPI
  property path = "", x = 0.0, y = 0.0

  def add_to_context(ctx)
    ctx.image @path, @x, @y

    ctx
  end
end

struct LineCapAPI < ElementAPI
  property value = ""

  def add_to_context(ctx)
    ctx.line_cap @value

    ctx
  end
end

struct LineJoinAPI < ElementAPI
  property value = ""

  def add_to_context(ctx)
    ctx.line_join @value

    ctx
  end
end

struct FontAPI < ElementAPI
  property name = "", size = 12

  def add_to_context(ctx)
    ctx.font @name, @size

    ctx
  end
end

struct FontSizeAPI < ElementAPI
  property size = 12

  def add_to_context(ctx)
    ctx.font_size @size

    ctx
  end
end

struct TextAlignAPI < ElementAPI
  property value = ""

  def add_to_context(ctx)
    ctx.text_align @value

    ctx
  end
end

struct LineHeightAPI < ElementAPI
  property value = ""

  def add_to_context(ctx)
    ctx.line_height @value

    ctx
  end
end

struct LineDashAPI < ElementAPI
  property values = [] of Int32, offset = 0

  def add_to_context(ctx)
    ctx.line_dash @values, @offset

    ctx
  end
end

struct TranslateAPI < ElementAPI
  property x = 0, y = 0

  def add_to_context(ctx)
    ctx.translate @x, @y

    ctx
  end
end

struct ScaleAPI < ElementAPI
  property x = 0, y = 0

  def add_to_context(ctx)
    ctx.scale @x, @y

    ctx
  end
end

struct TextAPI < ElementAPI
  property text = "", x = 0, y = 0

  def add_to_context(ctx)
    ctx.text @text, @x, @y

    ctx
  end
end

struct TextBoxAPI < ElementAPI
  property text = "", x = 0, y = 0, w = 0.0, h = 0.0

  def add_to_context(ctx)
    ctx.text_box @text, @x, @y, @w, @h

    ctx
  end
end

struct RotateAPI < ElementAPI
  property angle = 0, center_x = 0, center_y = 0

  def add_to_context(ctx)
    ctx.rotate @angle, @center_x, @center_y

    ctx
  end
end

struct PolygonAPI < ElementAPI
  property points = [] of Float64, close = true

  def add_to_context(ctx)
    ctx.polygon points, close

    ctx
  end
end

struct LineAPI < ElementAPI
  property x1 = 0.0, y1 = 0.0, x2 = 0.0, y2 = 0.0

  def add_to_context(ctx)
    ctx.line @x1, @y1, @x2, @y2

    ctx
  end
end

abstract struct ElementAPI
  {% begin %}
    # Macro for creating the Map with list of Subclasses
    use_json_discriminator "type", {
      {% for name in @type.subclasses %}
      {{ name.stringify.gsub(/API$/, "").underscore.id }}: {{ name.id }},
      {% end %}
    }
  {% end %}
end

def chitra_from_json(data : String)
  ctx = Chitra::Context.new(700, 700)
  elements = Array(ElementAPI).from_json(data)
  elements.each do |ele|
    ctx = ele.add_to_context(ctx)
  end
end
