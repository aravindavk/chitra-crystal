require "chitra"

background 1
gap = 100
x = y = gap
loop do
  break if y > height

  if x > width
    x = gap
    y += gap
  end

  no_stroke
  oval x, y
  x += gap
end

save "./docs/content/images/dots.png"
