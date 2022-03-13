require "../src/global_context"

# Set Fill color Red
fill 1, 0, 0
saved_state do
  # Change the fill color to Blue
  fill 0, 0, 1
  rect 100, 100, 200, 200
end

# Draw rect with the fill color set previously
rect 200, 200, 200, 200

save "docs/content/images/saved_state.png"
