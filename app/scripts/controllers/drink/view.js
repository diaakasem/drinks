// Generated by CoffeeScript 1.6.3
(function() {
  var controller;

  controller = function(scope, Service) {
    return Service.create(Service.newCoffee());
  };

  angular.module('drinksApp').controller('DrinkViewCtrl', ['$scope', 'DrinkService', controller]);

}).call(this);

/*
//@ sourceMappingURL=view.map
*/
