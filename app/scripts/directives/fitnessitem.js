// Generated by CoffeeScript 1.6.3
(function() {
  var controller;

  controller = function(scope, ParseCrud) {};

  angular.module('manageApp').directive('fitnessitem', function() {
    return {
      templateUrl: "views/directives/fitnessitem.html",
      restrict: 'E',
      transclude: true,
      scope: {
        selected: '@selected',
        scope: '=scope'
      },
      controller: ['$scope', 'ParseCrud', controller]
    };
  });

}).call(this);

/*
//@ sourceMappingURL=fitnessitem.map
*/
