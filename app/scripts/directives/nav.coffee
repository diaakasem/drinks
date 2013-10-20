controller = (location, scope, element, attrs) ->
  console.log 'hello'
    

angular.module('drinksApp')
  .directive 'navmenu', ->
    templateUrl: "views/directives/nav.html"
    restrict: 'E'
    scope: true
    controller: ['$location', '$scope', '$element', '$attrs', controller]
