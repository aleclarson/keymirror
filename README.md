
### keymirror 1.0.0 ![stable](https://img.shields.io/badge/stability-stable-4EBA0F.svg?style=flat)

**TODO:** Rewrite this using [`Type`](https://github.com/aleclarson/Type) if we can.

```coffee
KeyMirror = require "keymirror"

# Construct an empty KeyMirror.
m1 = KeyMirror()
m1._keys   # []
m1._length # 0

# Add your keys.
m1._add "a", "b", "c"
m1._keys # ["a", "b", "c"]

# Access your keys.
m1.a # "a"
m1.b # "b"
m1.c # "c"

# Remove your keys.
m1._remove "a", "c"

# Construct a KeyMirror from Arrays, Strings, Objects, and even KeyMirrors.
m2 = KeyMirror ["d"], "e", { f: 0 }, m1
m2._keys # ["b", "d", "e", "f"]

# Mix in those types after creation.
m2._add ["x"], { y: false }, "r2d2"
m2._keys # ["b", "d", "e", "f", "x", "y", "r2d2"]

# Clone a KeyMirror with clear intent.
m3 = m1._clone()
m3._keys # ["b"]
m3 is m1 # false
```
