controller = (scope, Service, timeout)->

  m = moment()
  dayMS = m.diff moment().startOf('day')

  scope.historyFilter = ''
  scope.tab = 'today'
  scope.entities = []
  scope.history = []
  scope.name = ''
  scope.tags = ''

  scope.tagsList = []
  scope.namesList = []

  buildBieChartData = (entities)->
    biedata = {}
    result = []
    _.each entities, (e)->
      biedata[e.get('tags')] ?= 0
      biedata[e.get('tags')] += 1

    console.log biedata
    results = ({'label': k, 'value': v} for k, v of biedata)
    #[ { key: "Cumulative Return", values: results }]
    
  graphBieChart = (data)->
    width = 960
    height = 500

    r = Math.min(width, height) / 2
    m = 10
    color = d3.scale.category20()
    arc = d3.svg.arc().innerRadius(r/2).outerRadius(r - m)
    pie = d3.layout.pie().sort(null).value((d) -> d.value)

    angle = (d)->
      a = (d.startAngle + d.endAngle) * 90 / Math.PI - 90
      if a > 90 then a - 180 else a

    svg = d3.select("#piechart svg")
      .attr("width", width)
      .attr("height", height)
      .append("g")
      .attr("transform", "translate(#{width / 2}, #{height / 2})")

    g = svg.selectAll(".arc")
      .data(pie(data))
      .enter()
      .append("g")
      .attr("class", "arc")

    g.append("path")
      .attr("d", arc)
      .style "fill", (d) -> color d.data.value

    g.append("svg:text")
      .attr("transform", (d) ->
        c = arc.centroid(d)
        "translate(#{c[0]}, #{c[1]})rotate(#{angle(d)})"
      ).attr("dy", ".35em")
      .style("text-anchor", "middle")
      .text (d)-> "#{d.data.label} (#{d.data.value})"

    svg.append("svg:text")
      .attr("dy", ".35em")
      .attr("text-anchor", "middle")
      .text "Monthly shares \n #{scope.history.length}"


  # Building the titles list
  buildLists = (entities)->
    _.each entities, (e)->
      scope.tagsList.push e.get('tags')
      scope.namesList.push e.get('name')
    scope.tagsList = _.uniq scope.tagsList
    scope.namesList = _.uniq scope.namesList

  # Listing today
  now = new Date()
  Service.list now, new Date(now - dayMS), (results)->
    scope.$apply ->
      scope.entities = results
      buildLists results

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

  scope.again = (model)->
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
          console.log "Pomodoros count last month: #{results.length}"
          scope.history = results
          timeout -> graphBieChart buildBieChartData(results)
          timeout -> buildLists results
          cb?(results)

  scope.isBar = yes

  amonthAgo = +(moment().subtract('days', 30).startOf('day'))
  aDay = 86400000
  end = +(moment().add('days', 2).startOf('day'))
  scope.lastMonth = _.range(amonthAgo, end, aDay)

  indent = (arr)->
    lastMonth = (0 for i in [0...scope.lastMonth.length])
    for a in arr
      day = +(moment(a.createdAt).startOf('day'))
      index = _.indexOf scope.lastMonth, day
      continue unless index >= 0
      lastMonth[index]++

    return lastMonth

  scope.c3BuildData = (historyData)->
    data = scope.entities.concat(historyData)
    data = _.groupBy data, (d)-> d.get('tags')
    res = _.map data, (v, k)-> [k].concat indent(v)
    res

  scope.showReports = ->
    scope.tab = 'reports'
    graph = (historyData)->
      data = scope.c3BuildData historyData
      type = 'bar'
      types = if scope.isBar then _.zipObject _.map(data, (d)->[d[0], type]) else []
      monthStrings = _.map scope.lastMonth, (d)->
        moment(d).format 'MM DD'
      columns = [['date'].concat monthStrings].concat data
      config =
        data:
          x: 'date'
          x_format: '%m %d'
          columns: columns
          types: types
          groups: [_.map(data, _.first)]
        axis:
          x:
            type : 'timeseries'
        subchart:
          show: yes

      chart = c3.generate config

    if scope.history.length > 0
      graph scope.history
    else
      scope.showHistory no, graph

  scope.filtered = (e)->
    regex = new RegExp ".*#{scope.historyFilter}.*", 'i'
    return yes unless scope.historyFilter
    regex.test(e.get('name')) or regex.test(e.get('tags'))

  scope.switch = ->
    $('#chart').empty()
    scope.isBar = not scope.isBar
    scope.showReports()

  $('#whatispomodoro').popover({})
  $('.withtooltip').tooltip({})

angular.module('manageApp')
  .directive('pomodorolist', () ->
    templateUrl: "views/directives/pomodorolist.html"
    restrict: 'E'
    scope: true
    controller: ['$scope', 'Pomodoro', '$timeout', controller]
  )
