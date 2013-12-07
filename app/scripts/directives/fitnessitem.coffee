controller = (scope, ParseCrud)->

angular.module('manageApp')
  .directive 'fitnessitem', () ->
    templateUrl: "views/directives/fitnessitem.html"
    restrict: 'E'
    transclude: yes
    scope:
      selected: '@selected'
      scope: '=scope'
    controller: ['$scope', 'ParseCrud', controller]
