require "chitra"

# A4 Page size
size 2480, 3508

fill 1, 0, 0
rect 500, 500, 500, 500

new_page

fill 0, 1, 0
rect 500, 500, 500, 500

new_page

fill 0, 0, 1
rect 500, 500, 500, 500

save "multipage.pdf"
