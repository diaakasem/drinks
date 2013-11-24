memoize = (fn, ttl)->
  lastTime = +new Date()
  m = _.memoize fn
  ->
    now = +new Date()
    if now - lastTime >= ttl
      lastTime = now
      m.cache = {}
    m()

controller =  (scope, timeout) ->

  if not scope.show
    return

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
    tick: 'sounds/tick.mp3'
    crank: 'sounds/crank.mp3'
    alarm: 'sounds/alarm.mp3'
    current: null

  play = (song)->
    #console.log "Playing #{song}"
    sounds.current?.pause()
    sounds.current = new Audio song
    sounds.current?.play()

  pausesTime = (->
    calcPauses = (p)-> p.end - p.start
    sum = (x,y)-> x + y
    ->
        res = _.reduce _.map(scope.model.get('pauses'), calcPauses), sum
        p = scope.model.get('pause')
        if p and p.start
          res += new Date() - p.start
        res or 0
  )()

  timePassed = ->
    (new Date() - scope.model.createdAt - pausesTime()) / 1000

  if timePassed() < 1
    play sounds.crank

  originalCount = scope.model.get('sprint') + scope.model.get('rest')

  count = memoize(->
    originalCount - timePassed()
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

  everyPeriod = 1000 # 1 second
  runInterval = ->
    timer = timeout runInterval, everyPeriod
    pause = scope.model.get('pause')
    unless pause.start
      if scope.model.get('status') isnt 'done'
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
        start: new Date()
        end: `undefined`
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
      onDone: '&done'
    replace: yes
    controller: ['$scope', '$timeout', controller]
