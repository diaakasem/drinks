controller = (location, scope, element, attrs) ->

angular.module('manageApp')
  .directive 'navcontainer', ->
    templateUrl: "views/directives/nav.html"
    restrict: 'E'
    scope: true
    replace: true
    controller: ['$location', '$scope', '$element', '$attrs', controller]
