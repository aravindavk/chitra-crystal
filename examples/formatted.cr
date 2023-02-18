require "chitra"

size 1000, 1000
background 1

fill 0
no_stroke

txt = FormattedString.new "Hello", size: 50
txt.weight = "bold"
txt.size = 50
txt.color = "#000000"
txt << " world!\n"

text txt, 50, 50

txt = FormattedString.new
txt.font = "Inter"
txt.size = 50
txt.underline = "error"
txt.underline_color = Chitra::Color.rgba2hex(0.7, 0, 0)
txt << "0123456789"

text txt, 50, 200

txt = FormattedString.new
txt.font = "Inter"
txt.size = 14.5
txt.features = "zero,tnum"
txt << "0123456789\n9876543210\n"
txt += "811\n288\n"

txt.color = "blue"
txt << "Blue"

txt.add "Green", color: "green", size: 10, tracking: 10
txt.add "Red", color: "red", transform: "uppercase"

text txt, 50, 300

txt = FormattedString.new size: 20, color: "#007ca3", font: "Inter"
txt << "First Paragraph\n"
txt << "Second Paragraph\n"
txt << FormattedString.new "Heading 2\n", size: 30
txt << "Paragraph again\n"
text txt, 50, 500

stroke_width 1
stroke 1, 0, 0
no_fill
txt = FormattedString.new "Yellow text and Red stroke\n", size: 50, color: "yellow"
text txt, 50, 700

save "formatted.png"
