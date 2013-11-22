onError = (error)->
  console.log error

class service
  constructor: ->
    @Entity = Parse.Object.extend "Idea"

  list: (cb)->
    query = new Parse.Query @Entity
    query.find
      success: cb
      error: onError

  remove: (model, cb)->
    model.destroy
      success: cb
      error: onError


  add: (cb, name='', parent='Ideas')->
    idea = new @Entity()
    pomodoro.set "parent", name
    pomodoro.set "name", name
    pomodoro.setACL(new Parse.ACL(Parse.User.current()))
    pomodoro.save
      success: cb
      error: onError

  update: (model, cb)->
    model.save
      success: cb
      error: onError

  
angular.module('drinksApp')
  .service 'Idea', service
