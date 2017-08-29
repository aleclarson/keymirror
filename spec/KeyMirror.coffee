
global.assert = (a, b) -> expect(a).toBe b
global.assert.not = (a, b) -> expect(a).not.toBe(b)
global.log = (message) -> process.stdout.write message

describe "KeyMirror", ->

  KeyMirror = require "../src/KeyMirror"

  describe "constructor", ->

    it "accepts Arrays as arguments", ->
      mirror = KeyMirror ["a", "b"]
      assert mirror.a, "a"
      assert mirror.b, "b"

    it "accepts Strings as arguments", ->
      mirror = KeyMirror "a", "b"
      assert mirror.a, "a"
      assert mirror.b, "b"

    it "accepts Objects as arguments", ->
      mirror = KeyMirror { a: "any value type is acceptable", b: false, c: 1 }
      assert mirror.a, "a"
      assert mirror.b, "b"
      assert mirror.c, "c"

    it "accepts KeyMirrors as arguments", ->
      mirror = KeyMirror "a"
      mirror2 = KeyMirror mirror
      assert mirror.a, mirror2.a

  describe "_add", ->

    it "accepts multiple arguments", ->
      mirror = KeyMirror()

    it "silently fails if the String already exists", ->
      mirror = KeyMirror "a"
      try
        mirror._add "a"
      catch e
        assert e?, false
        assert mirror._length, 1

  describe "_remove", ->

    it "accepts multiple Strings", ->
      mirror = KeyMirror "a", "b"
      mirror._remove "a", "b"
      assert mirror._length, 0
      assert mirror.a, undefined
      assert mirror.b, undefined

    it "silently fails if the String doesnt exist", ->
      mirror = KeyMirror "a"
      try 
        mirror._remove "b"
      catch e
        assert e?, false
        assert mirror._length, 1
        expect(mirror._keys).toEqual ["a"]

  describe "_clear", ->

    it "removes all keys", ->
      mirror = KeyMirror "a", "b", "c"
      mirror._clear()
      assert mirror._length, 0
      expect(mirror._keys).toEqual []

  describe "_clone", ->

    it "copies all keys", ->
      mirror = KeyMirror "a", "b", "c"
      mirror2 = mirror._clone()
      expect(mirror._keys).toEqual mirror2._keys

    it "creates a new KeyMirror", ->
      mirror = KeyMirror()
      mirror2 = mirror._clone()
      assert.not mirror, mirror2
