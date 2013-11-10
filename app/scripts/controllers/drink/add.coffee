controller = (scope) ->

  scope.create = (form)->
    Drink = Parse.Object.extend("Drink")
    drink = new Drink()
    drink.save form,
      success: (object)->
         Alert.success "Drink has been saved"


angular.module('drinksApp')
  .controller 'DrinkAddCtrl',
  ['$scope', controller]
