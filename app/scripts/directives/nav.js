// Generated by CoffeeScript 1.6.3
(function() {
  var controller;

  controller = function(location, scope, element, attrs) {
    return console.log('hello');
  };

  angular.module('drinksApp').directive('navcontainer', function() {
    return {
      templateUrl: "views/directives/nav.html",
      restrict: 'E',
      scope: true,
      transclude: true,
      replace: true,
      controller: ['$location', '$scope', '$element', '$attrs', controller]
    };
  });

}).call(this);

/*
//@ sourceMappingURL=nav.map
*/
