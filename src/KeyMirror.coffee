
has = require "has"

define = (obj, key, value, options) ->
  if !options? then options = {}
  else if options is "w" then options = writable: yes
  options.value = value
  Object.defineProperty obj, key, options

KeyMirror = module.exports = (sources...) ->
  return applyToNew KeyMirror, sources unless this instanceof KeyMirror
  define this, "_keys", [], "w"
  define this, "_length", 0, "w"
  _withKeys this, _add, sources

KeyMirrorProto =

  _add: (sources...) ->
    _withKeys this, _add, sources

  _remove: (sources...) ->
    _withKeys this, _remove, sources

  _replace: (sources...) ->
    @_clear()
    _withKeys this, _add, sources

  _clear: ->
    delete this[key] for key in @_keys
    @_keys = []
    @_length = 0
    @

  _clone: ->
    KeyMirror this

for key, value of KeyMirrorProto
  define KeyMirror.prototype, key, value

#
# Internal
#

applyToNew = (c, args) ->
  new ( c.bind.apply c, [c].concat args )

_add = (mirror, source, key) ->
  return no if has mirror, key
  mirror._length = mirror._keys.push mirror[key] = key
  yes

_remove = (mirror, source, key) ->
  return no unless has mirror, key
  delete mirror[key]
  mirror._keys.splice mirror._keys.indexOf(key), 1
  mirror._length--
  yes

_withKeys = (mirror, method, sources) ->
  for source in sources
    continue unless source?
    if typeof source is "string"
      result = method mirror, sources, source
    else
      for key in _keys source
        result = method mirror, source, key
  mirror

_keys = (source) ->
  if source instanceof Array
    return source
  if source instanceof KeyMirror
    return source._keys
  if source.constructor is Object
    return Object.keys source
  throw TypeError "Only Arrays, Objects, and KeyMirrors are accepted."
