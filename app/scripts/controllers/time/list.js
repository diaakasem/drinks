// Generated by CoffeeScript 1.6.3
(function() {
  var controller;

  controller = function(scope) {
    return scope.show = function(id) {
      $('.nav-pills .active').removeClass('active');
      $('.tab-pane.active').removeClass('active');
      $('.nav-pills li#' + id).addClass('active');
      $('.tab-pane#' + id).addClass('active');
      return '';
    };
  };

  angular.module('drinksApp').controller('TimeListCtrl', ['$scope', controller]);

}).call(this);

/*
//@ sourceMappingURL=list.map
*/
