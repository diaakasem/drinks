// Generated by CoffeeScript 1.6.3
(function() {
  var filter;

  filter = function() {
    return function(input) {
      if (input > 60) {
        input /= 60.0;
        input = Math.ceil(input);
      }
      return "" + (parseInt(input, 10));
    };
  };

  angular.module('manageApp').filter('timer', filter);

}).call(this);

/*
//@ sourceMappingURL=timer.map
*/
