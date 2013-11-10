controller = (scope, params) ->

  scope.model = {}
  
  Drink = Parse.Object.extend "Product"
  query = new Parse.Query Drink
  query.get params.id,
    success: (result)->
      scope.obj = result
      scope.$apply ->
        scope.model = result._serverData
    error: (e, err)->
      console.log e
      console.log err

angular.module('drinksApp')
  .controller 'DrinkViewCtrl',
  ['$scope', '$routeParams', controller]
