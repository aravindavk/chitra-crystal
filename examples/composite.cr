require "../src/global_context"

size 200, 200
background 1

no_stroke
font "Quicksand", 160

fill 1, 0, 0
text "8", 40, 20
oval 80, 40, 200, 200

fill 1
grouped do
  text "8", 40, 20
  composite "in"
  oval 80, 40, 200, 200
end

save "./docs/content/images/composite.png"
