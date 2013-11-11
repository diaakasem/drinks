controller = (scope, params) ->

  scope.model = {}
  
  Drink = Parse.Object.extend "Product"
  query = new Parse.Query Drink
  query.get params.id,
    success: (result)->
      scope.obj = result
      scope.$apply ->
        scope.model = result._serverData
    error: (e)->
      console.log e

  scope.update = (form)->
    _.each scope.model, (v, k)->
      scope.obj.set k, v
    scope.obj.save
      success: (r)->
        scope.go "/drink/view/#{params.id}"
      error: (e)->
        console.log e

angular.module('drinksApp')
  .controller 'DrinkEditCtrl',
  ['$scope', '$routeParams', controller]
