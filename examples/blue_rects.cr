require "../src/global_context"

size 600, 200

rect_s = 10
gap = 0
x = gap
y = gap
loop do
  if x > width
    x = gap
    y += rect_s + gap
  end

  break if y > height

  fill 0, 0, Random.new.rand(0.1...1.0)

  rect x, y, rect_s, rect_s
  x += rect_s + gap
end

save "blue_rects.png"
