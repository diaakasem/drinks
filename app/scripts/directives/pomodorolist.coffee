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

  scope.showHistory = (switchtab=yes, cb)->
    scope.tab ='history' if switchtab
    # Listing history
    if scope.history.length > 0
      cb?(scope.history)
    else
      Service.list new Date(now - dayMS), new Date(0), (results)->
        scope.$apply ->
          scope.history = results
          cb?(results)

  scope.isBar = yes
  scope.showReports = ->
    scope.tab = 'reports'
    scope.showHistory no, (historyData)->

      buildData = (isBar)->
        data = scope.entities.concat(historyData)
        data = _.groupBy data, (d)-> d.get('tags')
        data = _.map data, (arr, tag)->
          days = _.groupBy(arr, (d)->moment(d.createdAt).startOf('day').unix()*1000)
          v = _.map(days, (pomodoros, day)->
            count = if pomodoros then pomodoros.length else 0
            day = parseInt day
            if isBar then {x: day, y: count} else [day, count]
          )

          v = _.sortBy v, (d)->
            ret = if isBar then d.x else d[0]
            ret
          {key: tag, values: v}

        data = _.sortBy data, 'key'
        return data


      buildGraph = ->
        d3.select('svg g').remove()

        data = buildData(scope.isBar)
        console.log data

        if scope.isBar
          chart = nv.models.multiBarChart()
        else
          chart = nv.models.cumulativeLineChart()
                    .x((d)->d[0])
                    .y((d)->d[1])
                    .clipEdge(yes)

        chart.xAxis
          .axisLabel('Dates')
          .tickFormat((d)->
            console.log d
            moment(d).format('MMM Do')
          )

        chart.yAxis
          .axisLabel('Pomodoris')
          .tickFormat d3.format(",.1f")

        d3.select("#reports svg").datum(data)
          .transition().duration(1000).call chart

        chart
        nv.utils.windowResize chart.update


      scope.$watch 'isBar', (isBar)->
        nv.addGraph buildGraph

      nv.addGraph buildGraph


angular.module('manageApp')
  .directive('pomodorolist', () ->
    templateUrl: "views/directives/pomodorolist.html"
    restrict: 'E'
    scope: true
    controller: ['$scope', 'Pomodoro', controller]
  )
