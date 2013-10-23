controller = (scope, Service) ->

  scope.create = (form)->
    debugger;

angular.module('drinksApp')
  .controller 'DrinkAddCtrl',
  ['$scope', 'DrinkService', controller]
