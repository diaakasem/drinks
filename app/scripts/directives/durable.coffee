controller =  (scope, timeout) ->
  timer = null

  everySecond = ->
    timer = timeout everySecond, 1000
    unless scope.model.get('pause')
      scope.model.increment('count', -1)
      if scope.model.get('status') is 'work' and scope.model.get('count') <= 0
        scope.model.set('count', scope.model.get('break'))
        scope.model.set('status', 'rest')

      if scope.model.get('status') is 'rest' and scope.model.get('count') <= 0
        scope.model.set('status', 'done')
        scope.model.set('pause', yes)

      unless scope.model.get('status') is 'done'
        scope.onChange() scope.model
        
  everySecond()

  scope.doPause = ->
    scope.model.set('pause', !scope.model.get('pause'))
    scope.onChange() scope.model

  scope.doRemove = ->
    timeout.cancel timer
    scope.remove() scope.model


angular.module('drinksApp')
  .directive 'durable', ->
    templateUrl: 'views/directives/durable.html'
    restrict: 'E'
    scope:
      model:'='
      entity:'@'
      onChange: '&change'
      remove: '&remove'
    replace: yes
    controller: ['$scope', '$timeout', controller]
