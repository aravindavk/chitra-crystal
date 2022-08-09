require "../src/global_context"

background 0
font "Quicksand", 50
stroke 1, 0, 1
fill 0
no_stroke
rainbow "Hello World".split(""), 20, 20

rainbow "This$ is$ colorful$ text.$ How$ is$ it?".split("$"), 20, 100

rainbow "Awesome, nice and nice".split(""), 20, 180

rainbow "rainbow colors".split(""), 20, 260

rainbow "ಒತ್ತಕ್ಷರ".each_grapheme.to_a.map {|g| g.to_s}, 20, 340

save "rainbow.png"
