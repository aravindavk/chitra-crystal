require "chitra"

size 300, 30
background 1

fill "#555555"
stroke "#555555"
(0...10).each do |x|
  so = x > 10 ? 10 : x + 1
  fill_opacity x/10
  stroke_opacity so/10

  rect x*30, 0, 30, 30
end

save "./docs/content/images/fill_stroke_opacity.png"
