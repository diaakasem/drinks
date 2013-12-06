controller = (scope, Item, Consumption) ->

  m = moment()
  dayMS = m.diff moment().startOf('day')

  scope.consumptionFilter = ''

  scope.tab = 'consumption'

  scope.items = []
  scope.consumptions = []

  scope.name = ''
  scope.tags = ''

  scope.tagsList = []
  scope.namesList = []


  buildLists = (items)->
    _.each items, (e)->
      scope.tagsList.push e.get('tags')
      scope.namesList.push e.get('name')
    scope.tagsList = _.uniq scope.tagsList
    scope.namesList = _.uniq scope.namesList

  scope.remove = (model)->
    Item.remove model, ->
      scope.$apply ->
        scope.items = _.filter scope.items, (d)->
          d.id != model.id

  scope.add = ->
    cb = (result)->
      scope.$apply ->
        scope.items.unshift result
        scope.name = ''
        scope.tags = ''

    Item.add cb, scope.name, scope.tags

  scope.showConsumptions = (switchtab=yes, cb)->
    scope.tab ='consumption' if switchtab
    # Listing history
    if scope.consumptions.length > 0
      cb?(scope.consumptions)
    else
      Consumption.list new Date(now - dayMS), new Date(0), (results)->
        scope.$apply ->
          scope.consumptions = results
          timeout -> buildLists results
          cb?(results)

  scope.showItems = (switchtab=yes, cb)->
    scope.tab ='items' if switchtab
    # Listing history
    if scope.items.length > 0
      cb?(scope.items)
    else
      Item.list new Date(now - dayMS), new Date(0), (results)->
        scope.$apply ->
          scope.items = results
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

  scope.c3BuildData = (data)->
    data = scope.items.concat(data)
    data = _.groupBy data, (d)-> d.get('tags')
    res = _.map data, (v, k)-> [k].concat indent(v)
    res

  scope.showReports = ->
    scope.tab = 'reports'

  scope.filtered = (e)->
    regex = new RegExp ".*#{scope.consumptionFilter}.*", 'i'
    return yes unless scope.consumptionFilter
    regex.test(e.get('name')) or regex.test(e.get('tags'))

  scope.switch = ->
    $('#chart').empty()
    scope.isBar = not scope.isBar
    scope.showReports()

  $('#whatispomodoro').popover({})
  $('.withtooltip').tooltip({})

angular.module('manageApp')
  .controller 'FitnessCtrl',
  ['$scope', 'Item', 'Consumption', controller]
