controller = (scope)->

  scope.drinks = []
  Drink = Parse.Object.extend "Product"
  query = new Parse.Query Drink
  query.equalTo("type", "drink")
  query.find
    success: (results)->
      scope.$apply ->
        scope.drinks = _.map results, (d)->
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
          scope.drinks = _.filter scope.drinks, (d)->
            d.id != id
      error: (e)->
        console.log e

angular.module('drinksApp')
  .controller 'DrinkListCtrl',
  ['$scope', controller]
