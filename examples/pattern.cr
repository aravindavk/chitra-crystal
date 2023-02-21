require "chitra"

size 600, 600
background 255/256, 88/256, 0

def pattern
  no_stroke

  x = 0
  y = 50
  (1..20).each do
    fill 255/256, 132/256, 0
    rect x, y, 150, 100
    rect x + 50, y + 100, 100, 150

    fill 255/256, 48/256, 0
    rect x, y + 50, 150, 50
    rect x + 100, y + 100, 50, 150

    x += 150
    y += 150
  end
end

ty = -600.0
(0..4).each do
  translate 0, ty
  pattern
  translate 0, -ty
  ty += 300
end

save "./docs/content/images/pattern.png"
