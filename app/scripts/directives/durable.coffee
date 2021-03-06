timeNow = ->
  new Date().getTime()

memoize = (fn, ttl)->
  lastTime = timeNow()
  m = _.memoize fn
  ->
    now = timeNow()
    if now - lastTime >= ttl
      lastTime = now
      m.cache = {}
    m()

controller =  (scope, timeout) ->

  return unless scope.show

  # Mute by default
  scope.mute = yes
  scope.name = scope.model.get('name')
  scope.tags = scope.model.get('tags')

  scope.save = ->
    scope.model.set('name', scope.name)
    scope.model.set('tags', scope.tags)
    scope.model.save()
    scope.editing = false

  timer = null
  sounds =
    tick: 'tickSound'
    crank: 'crankSound'
    alarm: 'alarmSound'
    current: null
    last: null

  play = (song)->
    if song is sounds.last?
      sounds.current?.currentTime = 0
      sounds.current?.play() if sounds.current?.paused
    else
      sounds.current?.pause()
      sounds.last = song
      sounds.current = document.getElementById song
    if song isnt sounds.last?
      sounds.current?.play()

  pausesTime = (->
    calcPauses = (p)-> p.end - p.start
    sum = (x,y)-> x + y
    ->
      res = _.reduce _.map(scope.model.get('pauses'), calcPauses), sum
      res ?= 0
      p = scope.model.get('pause')
      if p?.start
        currentPause =  timeNow() - p.start
        res += currentPause
      res or 0
  )()

  timePassed = ->
    (timeNow() - scope.model.createdAt - pausesTime()) / 1000

  if timePassed() < 1
    play sounds.crank

  originalCount = scope.model.get('sprint') + scope.model.get('rest')

  count = memoize(->
    if scope.model.get('status') is 'done' then 0 else originalCount - timePassed()
  , 990)

  scope.getTime = memoize(->
    if scope.model.get('status') isnt 'done'
      if count() - scope.model.get('rest') > 0
        count() - scope.model.get('rest')
      else
        count()
    else
      0
  , 990)

  scope.anotherOne = ->
    scope.again() scope.model

  everyPeriod = 1000 # 1 second
  alreadyDone = yes
  runInterval = ->
    timer = timeout runInterval, everyPeriod
    pause = scope.model.get('pause')
    unless pause.start
      if scope.model.get('status') isnt 'done'
        alreadyDone = no
        if count() > 0
          unless scope.mute
            play sounds.tick
          else
            sounds.current?.pause()

          if scope.model.get('status') is 'work' and count() <= scope.model.get('rest')
            play sounds.alarm
            scope.model.set('status', 'rest')
            scope.onChange() scope.model
        else
            play sounds.alarm
            scope.model.set('status', 'done')
            scope.onChange() scope.model
      else
        timeout.cancel timer
        unless alreadyDone
          scope.onChange() scope.model
          scope.onDone() scope.model
    else
      sounds.current?.pause()


  timeout runInterval, everyPeriod

  scope.doPause = ->
    sounds.current?.pause()
    pause = scope.model.get 'pause'
    unless pause and pause.start
      scope.model.set 'pause',
        start: timeNow()
        end: `undefined`
    else
      pause.end = timeNow()
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

  $('.withtooltip').tooltip({})


angular.module('manageApp')
  .directive 'durable', ->
    templateUrl: 'views/directives/durable.html'
    restrict: 'E'
    scope:
      model:'='
      onChange: '&change'
      remove: '&remove'
      show: '='
      onDone: '&done'
      again: '&again'
      
    replace: yes
    controller: ['$scope', '$timeout', controller]
