require "../src/global_context"

size 600

# Square
#    x   y   w    h
rect 10, 10, 100, 100

# Rectangle
#    x   y    w    h
rect 10, 120, 100, 50

# Circle
#    x   y    w    h
oval 10, 180, 100, 100

# Oval
#    x   y    w    h
oval 10, 290, 100, 50

# Polygon
#       x1  y1   x2  y2   x3  y3   close 
polygon 10, 400, 50, 500, 10, 600, close: true

save "docs/content/images/shapes.png"
