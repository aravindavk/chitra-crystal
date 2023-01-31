require "chitra"

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

  fill Random.new.rand(0.0...1.0), Random.new.rand(0.0...1.0), Random.new.rand(0.0...1.0)

  rect x, y, rect_s, rect_s
  x += rect_s + gap
end

save "random_color_rects.png"
