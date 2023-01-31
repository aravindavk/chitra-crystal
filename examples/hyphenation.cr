require "chitra"

size 750, 300
background 1

txt = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque aliquet, ligula in finibus feugiat, massa lorem vestibulum sapien, in ultricies ante libero et libero. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aliquam imperdiet fermentum nisi, at vehicula sem commodo eu. Nunc consequat metus eu porta iaculis. Aliquam pharetra massa et ex tempus, fringilla sodales est vehicula. Phasellus maximus enim purus, malesuada venenatis ante vehicula et. Quisque in mattis ligula. Nulla consectetur lorem enim, ut facilisis orci interdum quis. Aenean rutrum eget dolor vel fringilla. Nulla facilisi. Curabitur at porttitor massa. Phasellus quis porta erat. Duis vestibulum, sapien vitae luctus commodo, arcu tellus vulputate purus, et luctus massa mauris et odio. Proin nec dapibus odio."

font "Latin Modern Roman", 12
no_stroke
line_height 1.1

text_box txt, 50, 50, 300, 200

hyphenation true
text_box txt, 400, 50, 300, 200

save "./hyphenation.png"
