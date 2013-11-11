controller = (scope) ->
  
  scope.model = {}

  scope.create = (form)->
    Drink = Parse.Object.extend("Product")
    drink = new Drink()
    scope.model.type = 'drink'
    drink.save scope.model,
      success: (object)->
         console.log "Drink has been saved"
         scope.go '/drink/list'
      error: (_, err)->
        console.log err



angular.module('drinksApp')
  .controller 'DrinkAddCtrl',
  ['$scope', controller]
