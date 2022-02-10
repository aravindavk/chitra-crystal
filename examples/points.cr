require "../src/global_context"

background 1
gap = 100
x = y = gap
loop do
  break if y > height

  if x > width
    x = gap
    y += gap
  end

  stroke_width 2
  point x, y
  x += gap
end

save "dots.png"
