controller = (scope)->
  Service.create Service.newCoffee()

angular.module('drinksApp')
  .controller 'DrinkViewCtrl',
  ['$scope', controller]
