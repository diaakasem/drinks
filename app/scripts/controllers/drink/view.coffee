controller = (scope, Service)->
  Service.create Service.newCoffee()

angular.module('drinksApp')
  .controller 'DrinkViewCtrl',
  ['$scope', 'DrinkService', controller]
