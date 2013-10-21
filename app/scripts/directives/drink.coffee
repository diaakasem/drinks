controller = (location, scope, element, attrs) ->
  console.log scope
    
angular.module('drinksApp')
  .directive 'drink', ->
    templateUrl: 'views/directives/drink.html'
    restrict: 'E'
    scope:
      name: '@'
      description: '@'
      img: '@'
    controller: ['$location', '$scope', '$element', '$attrs', controller]
