controller = (scope)->

  pomodoro = null

  scope.entities = []
  Time = Parse.Object.extend "Time"
  query = new Parse.Query Time
  query.equalTo("type", "pomodoro")
  query.find
    success: (results)->
      scope.$apply ->
        scope.entities = results
    error: (error)->
      console.log error

  scope.remove = (model)->
    model.destroy
      success: ->
        scope.$apply ->
          scope.entities = _.filter scope.entities, (d)->
            d.id != model.id
      error: (e)->
        console.log e

  scope.add = ()->
    pomodoro = new Time()
    pomodoro.set 'count', 25*60
    pomodoro.set 'break', 5*60
    pomodoro.set "type", "pomodoro"
    pomodoro.set "status", "work"
    pomodoro.save
      success: (result)->
        scope.$apply ->
          pomodoro = result
          scope.entities.push result
      error: (e)->
        console.log e

  scope.onRemove = (model)->
    scope.remove model

  scope.onChange = (model)->
    model.save
      success: ->
        console.log 'updated'
      error: (e)->
        console.log e

angular.module('drinksApp')
  .controller 'TimeListCtrl',
  ['$scope', controller]
