require "../src/global_context"

background 0
font "Quicksand", 50
stroke 1, 0, 1
fill 0
no_stroke
rainbow "Hello World".split(""), 20, 20

rainbow "This$ is$ colorful$ text.$ How$ is$ it?".split("$"), 20, 100

rainbow "Awesome, nice and nice".split(""), 20, 180

rainbow "rainbow colors", 20, 260

rainbow "ಒತ್ತಕ್ಷರ", 20, 340
rainbow "Made in India", 20, 430, colors: ["#FF9933", "#FFFFFF", "#138808"]

rainbow "Kannada ಕನ್ನಡ", 20, 500, colors: ["yellow", "red"]

save "rainbow.png"
