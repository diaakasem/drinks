controller =  (scope, timeout) ->

  if not scope.show
    return

  # Mute by default
  scope.mute = yes

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
  if scope.count < 1
    play sounds.crank

  originalCount = scope.model.get('sprint') + scope.model.get('rest')
  scope.count = originalCount - scope.count

  everyPeriod = 1000 # 1 second
  runInterval = ->
    timer = timeout runInterval, everyPeriod
    pause = scope.model.get('pause')
    unless pause.start
      if scope.model.get('status') isnt 'done'

        if scope.count > 0
          scope.count -= 1
          unless scope.mute
            play sounds.tick
          else
            sounds.current?.pause()

          if scope.model.get('status') is 'work' and scope.count <= scope.model.get('rest')
            play sounds.alarm
            scope.model.set('status', 'rest')
            scope.onChange() scope.model
        else
            play sounds.alarm
            scope.model.set('status', 'done')
            scope.onChange() scope.model
      else
        timeout.cancel timer
        scope.onChange() scope.model
    else
      sounds.current?.pause()


        
  timeout runInterval, everyPeriod

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


  scope.whenDone = (model)->
     model.get('status') is 'done'


angular.module('manageApp')
  .directive 'durable', ->
    templateUrl: 'views/directives/durable.html'
    restrict: 'E'
    scope:
      model:'='
      onChange: '&change'
      remove: '&remove'
      show: '='
    replace: yes
    controller: ['$scope', '$timeout', controller]
