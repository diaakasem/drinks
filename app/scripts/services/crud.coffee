crud = ->
  ->
    rest = {}

    handler = (cb, errCB)->
      return (err, data)->
        if err
          errCB(err)
        else
          cb?(data)

    list = (cb, errCB)->
      rest.all handler(cb, errCB)

    get = (id, cb, errCB)->
      rest.get id, handler(cb, errCB)

    create = (obj, cb, errCB)->
      rest.put Date.now(), obj, handler(cb, errCB)

    update = (obj, cb, errCB)->
      rest.put obj.id, obj, handler(cb,errCB)

    remove = (id, cb, errCB)->
      rest.del id, handler(cb, errCB)

    config = (api, baseUrl='/app/api') ->
      rest = new Indexed(api, key: 'id')
      @

    # Public API here
    config: config
    list: list
    get: get
    create: create
    update: update
    remove: remove

angular.module('drinksApp').factory 'Crud', crud
