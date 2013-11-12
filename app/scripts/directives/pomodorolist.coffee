controller = (scope, Service)->

  scope.entities = []

  Service.list (results)->
    scope.$apply ->
      scope.entities = results

  scope.remove = (model)->
    Service.remove model, ->
      scope.$apply ->
        scope.entities = _.filter scope.entities, (d)->
          d.id != model.id

  scope.add = (name)->
    cb = (result)->
      scope.$apply ->
        scope.entities.push result

    Service.add cb, name

  scope.onRemove = (model)->
    scope.remove model

  scope.onChange = (model)->
    Service.update model

angular.module('drinksApp')
  .directive('pomodorolist', () ->
    templateUrl: "views/directives/pomodorolist.html"
    restrict: 'E'
    scope: true
    controller: ['$scope', 'Pomodoro', controller]
  )
