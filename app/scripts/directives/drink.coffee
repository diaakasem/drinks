controller = (location, scope, element, attrs) ->
    
angular.module('manageApp')
  .directive 'drink', ->
    templateUrl: 'views/directives/drink.html'
    restrict: 'E'
    scope:
      name: '@'
      description: '@'
      img: '@'
    controller: ['$location', '$scope', '$element', '$attrs', controller]
