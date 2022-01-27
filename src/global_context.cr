require "./chitra"

module Chitra
  class_property global_context = Context.new
end

FUNCS = %w[width height enable_debug fill no_fill stroke
  stroke_width save new_drawing rect oval line
  line_dash line_cap line_join translate rotate scale
  polygon background
]

# Define the above global functions
# by calling equivalant context functions
{% begin %}
  {% for name, index in FUNCS %}
    def {{name.id}}(*args, **kwargs)
      Chitra.global_context.{{name.id}}(*args, **kwargs)
    end
  {% end %}
{% end %}

# Set the size and initialize the drawing surface
# ```
# #    width height
# size 1600, 900
# ```
def size(w, h)
  debug = Chitra.global_context.debug
  Chitra.global_context = Chitra::Context.new(w, h)
  Chitra.global_context.enable_debug if debug
end
