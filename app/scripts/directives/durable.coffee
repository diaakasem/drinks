controller =  (scope, timeout) ->
  timer = null

  pausesTime =  _.reduce _.map(scope.model.get('pauses'), (p)->
    if p.end then p.end - p.start else 0
  ), (x, y)->
      x + y

  pausesTime ?= 0

  scope.count = (new Date() - scope.model.createdAt - pausesTime) / 1000
  scope.count = scope.model.get('sprint') + scope.model.get('rest') - scope.count

  everySecond = ->
    timer = timeout everySecond, 1000

    pause = scope.model.get('pause')
    unless pause.start or scope.model.get('status') is 'done'
      if scope.count > 0
        scope.count -= 1
        if scope.model.get('status') is 'work' and scope.count <= scope.model.get('rest')
          scope.model.set('status', 'rest')
          scope.onChange() scope.model
      else

          scope.model.set('status', 'done')
          scope.onChange() scope.model
        
  timeout everySecond, 1000

  scope.doPause = ->
    pause = scope.model.get 'pause'
    unless pause.start
      scope.model.set 'pause',
        start: new Date()
        end: null
    else
      pause.end = new Date()
      scope.model.add('pauses', pause)
      scope.model.set('pause', {})
    scope.onChange() scope.model

  scope.doRemove = ->
    timeout.cancel timer
    scope.remove() scope.model

  scope.$on '$routeChangeStart', (next, current)->
    timeout.cancel timer
    scope.onChange() scope.model


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
