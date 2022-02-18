# Chitra - 2D graphics library

Crystal language library to generate 2D graphics.

## Name

Chitra is a Kannada(Karnataka, India) word which means Drawing.

## Install

Install Cairo

Ubuntu

```console
sudo apt install libcairo2 libcairo2-dev libpango1.0-dev
```

Fedora

```console
sudo yum install cairo-devel pango-devel
```

Mac

```console
brew install cairo pango
```

Add this to your application's shard.yml:

```yaml
dependencies:
  chitra:
    github: aravindavk/chitra
```

## Example (Global context)

```crystal
require "chitra/global_context"

size 200, 10
(0..100).each do |x|
    fill x/100, 0, 0
    rect x*2, 0, 2, height
end
save "all_red.png"
```

Above example produces nice gradient like below.

![All Red](docs/content/images/all_red.png)

## Example (Without using global context)

```crystal
require "chitra"

ctx = Chitra.new 200, 10
(0..100).each do |x|
    ctx.fill x/100, 0, 0
    ctx.rect x*2, 0, 2, ctx.height
end
ctx.save "all_red.png"
```

## Documentation

Read the docs [here](docs/).

## Thanks

- [Cairo Graphics](https://www.cairographics.org/)
- [Cairo crystal bindings](https://github.com/TamasSzekeres/cairo-cr)
- Drawing API syntax are inspired from [Drawbot](https://drawbot.com/) and [Processing](https://processing.org/).

## Contributing

- Fork it (https://github.com/aravindavk/chitra/fork)
- Create your feature branch (git checkout -b my-new-feature)
- Commit your changes (git commit -am 'Add some feature')
- Push to the branch (git push origin my-new-feature)
- Create a new Pull Request

## Contributors

- [Aravinda Vishwanathapura](https://github.com/aravindavk) - Creator and Maintainer
