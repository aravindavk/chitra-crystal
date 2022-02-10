require "../src/global_context"

background 1
font "Serif", 50
stroke 1, 0, 1
fill 0
text "Hello World", 0, 0

font "Latin Modern Roman", 12
no_stroke
fill 0.5, 0.45
rect 10, 90, 320, 320
text_align "left"
txt = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas rutrum erat eu tincidunt ornare. Donec ut sodales diam, a faucibus sapien. Sed eleifend posuere enim, eget condimentum massa eleifend in. Nullam laoreet tortor sit amet dolor tempor molestie. Pellentesque tincidunt magna nec est rhoncus, eu finibus orci ultrices. Phasellus vitae urna pharetra, tempus eros ut, ornare orci. Vivamus placerat commodo lobortis. Mauris euismod dapibus ipsum, in fermentum libero fringilla ut. Etiam vel diam ut quam cursus imperdiet sit amet eget metus."
fill 0
overflow = text_box txt, 20, 100, 300, 300

fill 0.5, 0.45
rect 340, 90, 320, 320
fill 0
puts text_box overflow, 350, 100, 300, 300
save "text.png"
