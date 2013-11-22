controller =  (scope, timeout) ->
  timer = null
  sounds =
    tick: 'sounds/tick.mp3'
    crank: 'sounds/crank.mp3'
    alarm: 'sounds/alarm.mp3'
    current: null

  play = (song)->
    #console.log "Playing #{song}"
    sounds.current?.pause()
    sounds.current = new Audio song
    sounds.current?.play()

  pausesTime =  _.reduce _.map(scope.model.get('pauses'), (p)->
    if p.end then p.end - p.start else new Date() - p.start
  ), (x, y)->
      x + y

  pausesTime ?= 0

  scope.count = (new Date() - scope.model.createdAt - pausesTime) / 1000
  scope.count = scope.model.get('sprint') + scope.model.get('rest') - scope.count

  everyCount = 1000
  everySecond = ->
    timer = timeout everySecond, everyCount
    pause = scope.model.get('pause')
    unless pause.start or scope.model.get('status') is 'done'
      if scope.count > 0
        scope.count -= 1
        play sounds.tick
        if scope.model.get('status') is 'work' and scope.count <= scope.model.get('rest')
          play sounds.alarm
          sounds.current?.pause()
          scope.model.set('status', 'rest')
          scope.onChange() scope.model
      else
          play sounds.alarm
          scope.model.set('status', 'done')
          scope.onChange() scope.model

        
  timeout everySecond, everyCount
  play sounds.crank

  scope.doPause = ->
    sounds.current?.pause()
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
    sounds.current?.pause()

  scope.$on '$routeChangeStart', (next, current)->
    timeout.cancel timer
    scope.onChange() scope.model
    sounds.current?.pause()


angular.module('manageApp')
  .directive 'durable', ->
    templateUrl: 'views/directives/durable.html'
    restrict: 'E'
    scope:
      model:'='
      onChange: '&change'
      remove: '&remove'
    replace: yes
    controller: ['$scope', '$timeout', controller]
