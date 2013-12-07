controller = (scope, timeout)->
  scope.consumptionFilter = ''

angular.module('manageApp')
  .directive 'fitness', () ->
    templateUrl: "views/directives/fitness.html"
    restrict: 'E'
    transclude: yes
    replace: yes
    scope:
      selectedtab: '@selectedtab'
    controller: ['$scope', '$timeout', controller]
