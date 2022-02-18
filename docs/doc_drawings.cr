require "../src/global_context"

u = 3

size u*70

# Shapes
background 1
rect u*10, u*10, u*50, u*50
save "docs/content/images/shapes_square.png"

new_drawing
background 1
rect u*10, u*10, u*50, u*20
save "docs/content/images/shapes_rect.png"

new_drawing
background 1
oval u*10, u*10, u*50, u*50
save "docs/content/images/shapes_circle.png"

new_drawing
background 1
oval u*10, u*10, u*50, u*20
save "docs/content/images/shapes_oval.png"

new_drawing
background 1
stroke_width u*1

#    x1   y1   x2   y2
line u*10, u*10, u*60, u*60
save "docs/content/images/shapes_line.png"

# ---------------------------
# Transformations - translate
# ---------------------------
new_drawing
background 1

def draw_rects(u)
  fill 1, 0, 0
  rect 0, 0, u*20, u*20

  fill 0, 0, 1
  rect u*10, u*10, u*20, u*20
end

# Move to middle of the canvas
translate width/2, height/2

draw_rects(u)

# Move back to original origin
translate -width/2, -height/2
save "docs/content/images/transformations_translate.png"

# ---------------------------
# Transformations - rotate
# ---------------------------
new_drawing
background 1
rotate 45
rect 0, 0, u*20, u*20
rect u*22, 0, u*20, u*20
save "docs/content/images/transformations_rotate_1.png"

# ---------------------------
# Transformations - rotate 2
# ---------------------------
new_drawing
background 1
rotate 45, u*35, u*35
rect u*25, u*25, u*20, u*20
save "docs/content/images/transformations_rotate_2.png"

# ---------------------------
# Transformations - Scale 1
# ---------------------------
new_drawing
background 1
rect u*2, u*2, u*20, u*20
translate u*24, u*24
scale 2
rect 0, 0, u*20, u*20
save "docs/content/images/transformations_scale_1.png"


# ---------------------------
# Transformations - Scale 2
# ---------------------------
new_drawing
background 1
rect u*2, u*2, u*20, u*20
translate u*24, u*24
scale 2, 1
rect 0, 0, u*20, u*20
save "docs/content/images/transformations_scale_2.png"

# -----------------------------
# Transformations - Saved State
# -----------------------------
new_drawing
background 1
# Fill color red
fill 1, 0, 0

translate u*5, u*5

saved_state do
  # Effective translate is (200, 200)
  translate u*10, u*10

  scale 2

  # Fill color blue
  fill 0, 0, 1
  rect 0, 0, u*20, u*20
end

# Rect with Red background, no scale
# and translation moved back to (50,50)
rect 0, 0, u*20, u*20
save "docs/content/images/transformations_saved_state.png"


# Background
new_drawing
size 50*u
background 1
save "docs/content/images/size_x.png"

new_drawing
size u*160, u*90
background 1
save "docs/content/images/size_x_y.png"

new_drawing
size u*70
background 0.5
save "docs/content/images/background_half_gray.png"

new_drawing
background 0.5, 0.5
save "docs/content/images/background_half_gray_opacity.png"

new_drawing
background 1, 0, 0
save "docs/content/images/background_rgb.png"

new_drawing
background 1, 0, 0, 0.5
save "docs/content/images/background_rgb_opacity.png"

new_drawing
background 1

rect width/4, height/4, width/2, height/2
save "docs/content/images/width_height.png"

# New Drawing
new_drawing
size 640, 70
background 1
no_stroke
font "Latin Modern Roman", 20

(0..100).each do |x|
    fill x/100, 0, 0
    rect 10 + x*2, 10, 2, 10
end
text_align "center"
fill 0
text_box "all_red.png", 10, 25, 200, 30

(0..100).each do |x|
    fill 0, x/100, 0
    rect 220 + x*2, 10, 2, 10
end
fill 0
text_box "all_green.png", 220, 25, 200, 30

(0..100).each do |x|
    fill 0, 0, x/100
    rect 430 + x*2, 10, 2, 10
end
fill 0
text_box "all_blue.png", 430, 25, 200, 30

save "docs/content/images/new_drawing.png"

new_drawing
size 70*u
background 1
fill 0.85
stroke 0
rect u*10, u*10, u*50, u*50

save "docs/content/images/colors_gray_scale.png"

new_drawing
background 1
fill 0, 0.5
stroke 0
rect u*10, u*10, u*50, u*50
save "docs/content/images/colors_gray_scale_opacity.png"

new_drawing
background 1
fill 1, 0, 0
stroke 0
rect u*10, u*10, u*50, u*50
save "docs/content/images/colors_rgb.png"

new_drawing
background 1
fill 1, 0, 0, 0.5
stroke 0
rect u*10, u*10, u*50, u*50
save "docs/content/images/colors_rgb_opacity.png"

new_drawing
background 1
no_fill
stroke 0
rect u*10, u*10, u*50, u*50
save "docs/content/images/colors_no_fill.png"

new_drawing
background 1
no_fill
stroke 0
stroke_width u*1
rect u*10, u*10, u*50, u*50
save "docs/content/images/colors_no_fill_stroke_width.png"

new_drawing
background 1
fill 0, 0, 1, 0.5
no_stroke
rect u*10, u*10, u*50, u*50
save "docs/content/images/colors_no_stroke.png"

new_drawing
background 1

fill 0
oval 100, 100

save "docs/content/images/shapes_point.png"


# -----------------------------
# Text - default
# -----------------------------
new_drawing
size 60*u, 40*u
background 1

no_stroke
text "Hello World!", 20*u, 20*u
save "docs/content/images/text_default.png"

# -----------------------------
# Text - Font
# -----------------------------
new_drawing
size 60*u, 40*u
background 1

no_stroke
font "Latin Modern Roman", 20
text "Hello World!", 20*u, 20*u
save "docs/content/images/text_font.png"

# -----------------------------
# Text - color
# -----------------------------
new_drawing
size 60*u, 40*u
background 1

fill 1, 0, 0
no_stroke
text "Hello World!", 20*u, 20*u
save "docs/content/images/text_color.png"


# -----------------------------
# Text box - align
# -----------------------------
new_drawing
size 70*u, 40*u
background 1

no_stroke
text_align "center"
font "Times", 20
text_box "Hello World!", 0, 10, width, height
save "docs/content/images/text_box_align.png"

# -----------------------------
# Text box - overflow
# -----------------------------
new_drawing
size 380*u, 80*u
background 1

no_stroke
font "Latin Modern Roman", 14
gap = 20*u
x = gap
w = 100*u
h = 60*u
text_align "justify"
txt = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec est velit, posuere ac molestie et, pharetra nec magna. Morbi vel sapien vulputate, malesuada enim a, fringilla risus. Nam vulputate risus id euismod finibus. Vestibulum molestie volutpat mauris, vitae viverra tortor. Nam non felis non nibh laoreet semper nec ut felis. Donec tempus augue a urna venenatis laoreet. Donec mi nunc, blandit vel augue nec, ullamcorper mattis nunc. Ut tristique laoreet laoreet. In purus eros, rhoncus ut ante in, tincidunt tristique nulla. Proin elit nunc, eleifend eu ex eget, imperdiet molestie nibh. Nullam vel viverra elit. Nullam tempus sodales libero, id aliquam lacus tempus ut. Vestibulum suscipit efficitur lacus eu condimentum. Nunc iaculis velit vel eros pulvinar, sed vestibulum nulla semper. Ut nibh erat, porta sit amet ipsum at, aliquet vehicula dui."

loop do
   txt = text_box txt, x, 10*u, w, h
   x += w + gap
    break if txt == ""
end

save "docs/content/images/text_box_overflow.png"
