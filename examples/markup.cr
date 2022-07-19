require "../src/global_context"

background 1
font "Serif", 50
stroke 1, 0, 1
fill 0
no_stroke
text "Hello World", 20, 20

font "Latin Modern Roman", 12
no_stroke
fill 0.5, 0.45
rect 10, 90, 320, 320
text_align "left"
line_height 1.1
heading_txt = "<span size=\"25600\">This is Heading!\n\n</span>"
txt = "Lorem <b>ipsum</b> dolor sit amet, consectetur adipiscing elit. <span color=\"green\">Maecenas</span> rutrum erat eu tincidunt ornare. Donec ut sodales diam, a faucibus sapien. Sed eleifend posuere enim, eget condimentum massa eleifend in. Nullam laoreet tortor sit amet dolor tempor molestie. Pellentesque <span underline=\"single\">tincidunt magna</span> nec est rhoncus, eu finibus orci ultrices. Phasellus vitae urna pharetra, tempus eros ut, ornare orci. Vivamus placerat commodo lobortis. Mauris euismod dapibus ipsum, in fermentum libero fringilla ut. Etiam vel diam ut quam cursus imperdiet sit amet eget metus."
fill 0
overflow, _w, _h = markup_box heading_txt + txt*2, 20, 100, 300, 300

fill 0.5, 0.45
rect 340, 90, 320, 320
fill 0
puts markup_box overflow, 350, 100, 300, 300
save "markup.png"
