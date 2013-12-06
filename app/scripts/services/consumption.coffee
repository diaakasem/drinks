onError = (error)->
  console.log error

class service
  constructor: ->
    @instance = Parse.Object.extend "Consumption"

  list: (end=new Date(), start=new Date(0), cb)->
    query = new Parse.Query @instance
    query.lessThan 'createdAt', new Date(end)
    query.greaterThan 'createdAt', new Date(start)
    query.descending 'createdAt'
    query.find
      success: cb
      error: onError

  remove: (model, cb)->
    model.destroy
      success: cb
      error: onError

  add: (cb, data={})->
    entity = new @Pomodoro()
    for k, v of data
      entity.set k, v

    entity.setACL(new Parse.ACL(Parse.User.current()))
    entity.save
      success: cb
      error: onError

  update: (model, cb)->
    model.save
      success: cb
      error: onError

angular.module('manageApp')
  .service 'Consumption', service
