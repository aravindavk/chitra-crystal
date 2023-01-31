require "chitra/json_api"

chitra_from_json(%Q[
  [
    {"type": "size", "w": 300, "h": 300},
    {"type": "background", "gray": 1},
    {"type": "stroke", "r": 1},
    {"type": "fill", "hex": "#ffff00"},
    {"type": "rect", "x": 50.0, "y": 50.0, "w": 200, "h": 200},
    {"type": "save", "path": "docs/content/images/hello_json.png"}
  ]
])
