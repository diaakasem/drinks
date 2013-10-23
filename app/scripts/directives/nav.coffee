controller = (location, scope, element, attrs) ->
  console.log 'hello'
    

angular.module('drinksApp')
  .directive 'navcontainer', ->
    templateUrl: "views/directives/nav.html"
    restrict: 'E'
    scope: true
    transclude: true
    replace: true
    controller: ['$location', '$scope', '$element', '$attrs', controller]
