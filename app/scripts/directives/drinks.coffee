controller = (Service, location, scope, element, attrs) ->
    
angular.module('drinksApp')
  .directive 'drinks', (Service) ->
    templateUrl: 'views/directives/drink.html'
    restrict: 'E'
    scope: true
    controller: ['Drink', '$location', '$scope', '$element', '$attrs', controller]
