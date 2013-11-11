controller = (location, scope, element, attrs) ->
    
angular.module('drinksApp')
  .directive 'drinks', ->
    templateUrl: 'views/directives/drinks.html'
    restrict: 'E'
    scope: true
    transclude: true
    replace: true
    controller: ['$location', '$scope', '$element', '$attrs', controller]