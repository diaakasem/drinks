controller = (scope)->


  scope.entities = []
  scope.name = ''

  Task = Parse.Object.extend "Task"
  query = new Parse.Query Task
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

  scope.add = (form)->
    todo = new Task()
    todo.set "status", "created"
    todo.set "name", scope.name
    todo.setACL(new Parse.ACL(Parse.User.current()))
    todo.save
      success: (result)->
        scope.$apply ->
          scope.entities.push result
          scope.name = ''
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
  .directive('todolist', () ->
    templateUrl: "views/directives/todolist.html"
    restrict: 'E'
    scope: true
    controller: ['$scope', controller]
  )
