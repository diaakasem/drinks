controller = (location, scope, element, attrs) ->
  parts = location.$$path.split('/')
  scope.page = parts[1]
  scope.action = parts[2]
  scope.id = parts[3]

angular.module('drinksApp')
  .directive 'entitynav', ->
    templateUrl: 'views/directives/entitynav.html'
    restrict: 'E'
    scope: true
    controller: ['$location', '$scope', '$element', '$attrs', controller]
