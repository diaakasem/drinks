controller = (scope, Service)->

  scope.entities = []
  scope.name = ''

  Service.list (results)->
    scope.$apply ->
      scope.entities = results

  scope.remove = (model)->
    Service.remove model, ->
      scope.$apply ->
        scope.entities = _.filter scope.entities, (d)->
          d.id != model.id

  scope.add = ->
    cb = (result)->
      scope.$apply ->
        scope.entities.push result
        scope.name = ''

    Service.add cb, scope.name

  scope.onRemove = (model)->
    scope.remove model

  scope.onChange = (model)->
    Service.update model

  scope.today = (model)->
    res = moment().diff moment(model.createdAt)
    dayMS = moment().diff moment().startOf('day')
    output = res < dayMS
    output

angular.module('manageApp')
  .directive('pomodorolist', () ->
    templateUrl: "views/directives/pomodorolist.html"
    restrict: 'E'
    scope: true
    controller: ['$scope', 'Pomodoro', controller]
  )
