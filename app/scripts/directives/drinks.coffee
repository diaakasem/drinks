controller = (location, scope, element, attrs) ->
    
angular.module('manageApp')
  .directive 'manage', ->
    templateUrl: 'views/directives/manage.html'
    restrict: 'E'
    scope: true
    transclude: true
    replace: true
    controller: ['$location', '$scope', '$element', '$attrs', controller]
