controller = (scope, Service)->

  scope.entities = []
  scope.name = ''
  scope.tags = ''

  Service.list (results)->
    scope.$apply ->
      scope.entities = _.sortBy(results, 'createdAt').reverse()

  scope.remove = (model)->
    Service.remove model, ->
      scope.$apply ->
        scope.entities = _.filter scope.entities, (d)->
          d.id != model.id

  scope.add = ->
    cb = (result)->
      scope.$apply ->
        scope.entities.unshift result
        scope.name = ''
        scope.tags = ''

    Service.add cb, scope.name, scope.tags

  scope.onRemove = (model)->
    scope.remove model

  scope.onChange = (model)->
    Service.update model

  scope.onDone = (model)->
    if scope.continus
      scope.name = model.get('name')
      scope.tags = model.get('tags')
      scope.add()

  scope.today = (->
    m = moment()
    dayMS = m.diff moment().startOf('day')
    console.log dayMS
    (model)->
      res = m.diff moment(model.createdAt)
      res < dayMS
  )()

angular.module('manageApp')
  .directive('pomodorolist', () ->
    templateUrl: "views/directives/pomodorolist.html"
    restrict: 'E'
    scope: true
    controller: ['$scope', 'Pomodoro', controller]
  )
