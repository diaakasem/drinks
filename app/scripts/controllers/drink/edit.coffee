controller = (scope, params) ->

  scope.model = {}
  
  Drink = Parse.Object.extend "Product"
  query = new Parse.Query Drink
  query.equalTo("type", "drink")
  query.equalTo("id", params.id)
  query.find
    success: (results)->
      scope.$apply ->
        _.first results, (result)->
          scope.model = result

  scope.update = (form)->
    Drink = Parse.Object.extend("Product")
    scope.model.save()

angular.module('drinksApp')
  .controller 'DrinkEditCtrl',
  ['$scope', '$routeParams', controller]
