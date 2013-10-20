crud = (Restangular) ->
  ->
    rest = {}

    cached = {}
    # 5 minutes
    cachedfor = 60 * 5 * 1000
    getCached = (id)->
      if cached[id]?.date < ((+new Date()) - cachedfor)
        return null
      return cached[id]
    
    cache = (id, obj)->
      cached[id] =
        obj: obj
        date: +new Date()

    withCache = (method)->
      return (id, cb, errCB)->
        cachedObj = getCached(id)
        if cachedObj
          cb cachedObj.obj
        else
          cachedCallback = (obj)->
            cache id, obj
            cb obj

          method id, cachedCallback, errCB

    onObjReturn = (cb, errCB)->
      return (data)->
        if data.error
          errCB?(data.error)
        else
          cb?(data.result)

    onList = (cb, errCB)->
      return (res)->
        if res.length > 0
          data = res[0]
          onObjReturn(cb, errCB)(data)
        else
          cb?([])

    list = (cb, errCB)->
      rest.getList().then onList(cb, errCB)

    get = withCache (id, cb, errCB)->
      rest.one(id).get().then onObjReturn(cb, errCB)

    create = (obj, cb, errCB)->
      rest.post(obj).then onObjReturn(cb, errCB)

    update = (obj, cb, errCB)->
      if cached[obj.id]
        delete cached[obj.id]
      # We have to use one to get restangular object
      rest.one(obj.id).get().then (d)->
        d.newData = obj
        d.put().then onObjReturn(cb,errCB)

    remove = (id, cb, errCB)->
      if cached[id]
        delete cached[id]
      rest.one(id).remove().then cb, errCB

    config = (api, baseUrl='/app/api') ->
      rest = Restangular.withConfig((configurer)->
        configurer.setBaseUrl baseUrl
        configurer.setResponseExtractor (response, operation, what, url)->
          if (operation is "getList")
            return [response]
          response

        configurer.setRequestInterceptor (element, operation, route, url)->
          result = element
          if operation is 'put'
            result = element.newData
          if operation is 'put' or operation is 'post'
            _.forOwn element.newData, (v, k)->
              if not v
                result[k] = false
          return result

      ).all(api)
      @

    # Public API here
    config: config
    list: list
    get: get
    create: create
    update: update
    remove: remove

angular.module('drinksApp').factory 'Crud', ['Restangular', crud]
