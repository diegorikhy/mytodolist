setTimeout ->
  @Array::first = -> @[0]
  @Array::last = -> @slice(-1)[0]

  @Array::inArray = (e) ->
    e in @

  @Array::any = (id)->
    @.length > 0

  @Array::many = (id)->
    @.length > 1

  @Array::empty = (id)->
    !@.any()

  @Array::indexOfById = (id)->
    for el, idx in @
      return idx if el.id == id
    return -1

  @Array::getById = (id)->
    if id instanceof Array
      id.map (_id)=> @getById(_id)
    else
      @[@indexOfById(id)]

  @Array::remove = (el)->
    idx = @indexOf(el)
    @splice idx, 1 if idx > -1

  @Array::removeById = (id)->
    @removeByField('id', id)

  @Array::removeByField = (field, value)->
    field = 'id' if field == undefined

    idx = []
    for el,i in @
     idx.push i if el[field] == value

    while idx.length > 0
      (@splice idx.pop(), 1)[0]

  @Array::extractFrom = (deepObject)->
    _carry = deepObject

    for _attr in @
      _carry = _carry?[_attr]

    _carry

  @Array::addOrExtend = (obj)->
    idx = if obj.id? then @indexOfById(obj.id) else @indexOf(obj)
    if idx is -1
      @push obj
    else
      angular.extend @[idx], obj

  @Array::somar = (field)->
    _arr = if field then @.map((e)-> e[field]) else @

    _arr.reduce (mem,el)->
      +mem + +el
