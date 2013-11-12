controller =  (scope, timeout) ->
  timer = null
  if not scope.model.get('count')
    scope.model.set('count', scope.model.get('sprint'))
    console.log scope.model.get('count')

  everySecond = ->
    timer = timeout everySecond, 60000

    unless scope.model.get('pause')

      if scope.model.get('count') > 0
        scope.model.increment 'count', -1
      else

        if scope.model.get('status') is 'work'
          scope.model.set('count', scope.model.get('break'))
          scope.model.set('status', 'rest')

        else if scope.model.get('status') is 'rest'
          scope.model.set('status', 'done')
          scope.model.set('pause', yes)
          scope.model.set('count', scope.model.get('break') + scope.model.get('sprint'))

      unless scope.model.get('status') is 'done'
        scope.onChange() scope.model
        
  timeout everySecond, 60000

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
      onChange: '&change'
      remove: '&remove'
    replace: yes
    controller: ['$scope', '$timeout', controller]
