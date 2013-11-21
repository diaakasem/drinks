controller = (scope)->

  scope.manage = []
  Drink = Parse.Object.extend "Product"
  query = new Parse.Query Drink
  query.equalTo("type", "drink")
  query.find
    success: (results)->
      scope.$apply ->
        scope.manage = _.map results, (d)->
          x = d._serverData
          x.id = d.id
          x
    error: (error)->
      console.log error

  scope.remove = (id)->
    Drink = Parse.Object.extend "Product"
    query = new Parse.Query Drink
    query.get id,
      success: (result)->
        scope.$apply ->
          result.destroy()
          scope.manage = _.filter scope.manage, (d)->
            d.id != id
      error: (e)->
        console.log e

angular.module('manageApp')
  .controller 'DrinkListCtrl',
  ['$scope', controller]
