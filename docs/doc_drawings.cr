require "../src/global_context"

u = 3

size u*70, u*70

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
