controller = (scope, Drink)->
  Drink.create Drink.newCoffee()

angular.module('drinksApp')
  .controller 'DrinkListCtrl',
  ['$scope', 'Drink', controller]
