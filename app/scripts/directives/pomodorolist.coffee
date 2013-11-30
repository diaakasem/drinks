controller = (scope, Service)->

  m = moment()
  dayMS = m.diff moment().startOf('day')

  scope.tab = 'today'
  scope.entities = []
  scope.history = []
  scope.name = ''
  scope.tags = ''

  # Listing today
  now = new Date()
  Service.list now, new Date(now - dayMS), (results)->
    scope.$apply ->
      console.log results
      scope.entities = results

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

  scope.showHistory = ->
    scope.tab='history'

    # Listing history
    Service.list new Date(now - dayMS), new Date(0), (results)->
      scope.$apply ->
        console.log results
        scope.history = results
        chart = graph()
        setTimeout ->
          chart.update()
        , 100

  graph = ->
    data = scope.history.reverse()
    data = _.groupBy scope.history, (d)-> d.get('tags')
    data = _.map data, (arr, k)->
      days = _.groupBy(arr, (d)->moment(d.createdAt).startOf('day'))
      v = _.map(days, (v, k)-> {x: k, y: v.length})
      {key: k, values: v}
    console.log data
    nv.addGraph ->
      chart = nv.models.multiBarChart()
      chart.xAxis.tickFormat (d)-> moment(new Date(d)).format('MMM Do')
      chart.yAxis.tickFormat d3.format(",.1f")
      d3.select("#reports svg").datum(data).transition().call chart
      nv.utils.windowResize chart.update
      chart


angular.module('manageApp')
  .directive('pomodorolist', () ->
    templateUrl: "views/directives/pomodorolist.html"
    restrict: 'E'
    scope: true
    controller: ['$scope', 'Pomodoro', controller]
  )
