onError = (error)->
  console.log error

class service
  constructor: ->
    @Pomodoro = Parse.Object.extend "Pomodoro"

  list: (cb)->
    query = new Parse.Query @Pomodoro
    query.find
      success: cb
      error: onError

  remove: (model, cb)->
    model.destroy
      success: cb
      error: onError


  add: (cb, name='', sprint=25*60, rest=5*60)->
    pomodoro = new @Pomodoro()
    pomodoro.set 'sprint', sprint
    pomodoro.set 'rest', rest
    pomodoro.set "status", "work"
    pomodoro.set "name", name
    pomodoro.set "pause", {}
    pomodoro.save
      success: cb
      error: onError

  update: (model, cb)->
    model.save
      success: cb
      error: onError

  
angular.module('manageApp')
  .service 'Pomodoro', service
