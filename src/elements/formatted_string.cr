# Name, Type, Attr name
FSTR_ATTRS = [
  {"font", "String?", "face"},
  {"size", "String? | Int32? | Float64?", "size"},
  {"style", "String?", "style"},
  {"weight", "String?", "weight"},
  {"variant", "String?", "variant"},
  {"stretch", "String?", "stretch"},
  {"features", "String?", "font_features"},
  {"color", "String?", "color"},
  {"bgcolor", "String?", "bgcolor"},
  {"alpha", "String?", "alpha"},
  {"bgalpha", "String?", "bgalpha"},
  {"underline", "String?", "underline"},
  {"underline_color", "String?", "underline_color"},
  {"overline", "String?", "overline"},
  {"overline_color", "String?", "overline_color"},
  {"rise", "String?", "rise"},
  {"baseline_shift", "String?", "baseline_shift"},
  {"font_scale", "String?", "font_scale"},
  {"strikethrough", "Bool?", "strikethrough"},
  {"strikethrough_color", "String?", "strikethrough_color"},
  {"fallback", "String?", "fallback"},
  {"lang", "String?", "lang"},
  {"tracking", "Int32?", "letter_spacing"},
  {"gravity", "String?", "gravity"},
  {"gravity_hint", "String?", "gravity_hint"},
  {"show", "String?", "show"},
  {"insert_hyphens", "Bool?", "insert_hyphens"},
  {"allow_breaks", "String?", "allow_breaks"},
  {"line_height", "Int32?", "line_height"},
  {"transform", "String?", "text_transform"},
  {"segment", "String?", "segment"},
]

class FormattedStringAttributeError < Exception
end

struct FormattedString
  property value = ""

  {% for a in FSTR_ATTRS %}
    property {{ a[0].id }} : {{ a[1].id }}
  {% end %}

  def numeric_or_str(val)
    return val.to_f.to_i * 1024 if val
  rescue ArgumentError
    val
  end

  def raise_error(attr_name, value)
    raise FormattedStringAttributeError.new "invalid #{attr_name} attribute value \"#{value}\""
  end

  def validated_font(value)
    value
  end

  def validated_size(value)
    numeric_or_str(value)
  end

  def validated_style(value)
    return value if ["normal", "oblique", "italic"].includes?(value)

    raise_error "style", value
  end

  def validated_weight(value)
    value.to_i
  rescue ArgumentError
    unless %w[ultralight light normal bold ultrabold heavy].includes?(value)
      raise_error "weight", value
    end

    value
  end

  def validated_variant(value)
    if ["normal", "small-caps", "all-small-caps", "petite-caps", "all-petite-caps", "unicase", "title-caps"].includes?(value)
      return value
    end
    raise_error "variant", value
  end

  def validated_stretch(value)
    values = ["ultracondensed", "extracondensed", "condensed", "semicondensed", "normal", "semiexpanded", "expanded", "extraexpanded", "ultraexpanded"]
    return value if values.includes?(value)

    raise_error "stretch", value
  end

  def validated_features(value)
    value
  end

  def validated_color(value)
    value
  end

  def validated_bgcolor(value)
    value
  end

  def validated_alpha(value)
    value
  end

  def validated_bgalpha(value)
    value
  end

  def validated_underline(value)
    value
  end

  def validated_underline_color(value)
    return value[0..6] if value.starts_with?("#")

    value
  end

  def validated_overline(value)
    value
  end

  def validated_overline_color(value)
    value
  end

  def validated_rise(value)
    value
  end

  def validated_baseline_shift(value)
    value
  end

  def validated_font_scale(value)
    value
  end

  def validated_strikethrough(value)
    value
  end

  def validated_strikethrough_color(value)
    value
  end

  def validated_fallback(value)
    value
  end

  def validated_lang(value)
    value
  end

  def validated_tracking(value)
    value*1024
  end

  def validated_gravity(value)
    value
  end

  def validated_gravity_hint(value)
    value
  end

  def validated_show(value)
    value
  end

  def validated_insert_hyphens(value)
    value
  end

  def validated_allow_breaks(value)
    value
  end

  def validated_line_height(value)
    value
  end

  def validated_transform(value)
    value
  end

  def validated_segment(value)
    value
  end

  def markup
    attrs = [] of String
    {% for a in FSTR_ATTRS %}
      val = @{{ a[0].id }}
      attrs << %Q[{{ a[2].id }}="#{validated_{{ a[0].id }}(val)}"] if val
    {% end %}
    "<span #{attrs.join(" ")}>#{@value}</span>"
  end

  def to_s(io)
    io << "<span>#{@content.join ""}</span>"
  end

  macro define_initialize
    def initialize(@value = ""{% for a in FSTR_ATTRS %}, @{{ a[0].id }} = nil{% end %})
      @content = [] of String
      @content << markup
    end
  end

  define_initialize

  def default_args(args)
    # Lists all the instance vars and generates the function
    # content. Example, for each instance vars
    # @weight = args[:weight]? if @weight.nil?
    {% for a in FSTR_ATTRS %}
          # If @{{ a[0].id }} is nil then set the default passed(args[:{{ a[0].id }}])
          @{{ a[0].id }} = args[:{{ a[0].id }}]? if @{{ a[0].id }}.nil?
    {% end %}
  end

  # Automatically construct the NamedTuple for all the available
  # instance variables excluding content and value.
  macro auto_args
    {
      {% for a in FSTR_ATTRS %}
      {{ a[0].id }}: @{{ a[0].id }},
      {% end %}
    }
  end

  def append(val)
    case val
    in String
      @content << FormattedString.new(val, **auto_args).markup
    in FormattedString
      val.default_args(auto_args)
      @content << val.markup
    end

    self
  end

  def <<(val : String | FormattedString)
    append(val)
  end

  def +(val : String | FormattedString)
    append(val)
  end

  def add(*args, **kwargs)
    @content << FormattedString.new(*args, **auto_args.merge(kwargs)).markup
  end
end
