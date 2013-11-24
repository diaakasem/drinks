// Generated by CoffeeScript 1.6.3
(function() {
  var controller;

  controller = function(scope, Service) {
    scope.entities = [];
    scope.name = '';
    Service.list(function(results) {
      return scope.$apply(function() {
        return scope.entities = _.sortBy(results, 'createdAt').reverse();
      });
    });
    scope.remove = function(model) {
      return Service.remove(model, function() {
        return scope.$apply(function() {
          return scope.entities = _.filter(scope.entities, function(d) {
            return d.id !== model.id;
          });
        });
      });
    };
    scope.add = function() {
      var cb;
      cb = function(result) {
        return scope.$apply(function() {
          scope.entities.unshift(result);
          return scope.name = '';
        });
      };
      return Service.add(cb, scope.name);
    };
    scope.onRemove = function(model) {
      return scope.remove(model);
    };
    scope.onChange = function(model) {
      return Service.update(model);
    };
    scope.onDone = function(model) {
      if (scope.continus) {
        scope.name = model.get('name');
        return scope.add();
      }
    };
    return scope.today = (function() {
      var dayMS, m;
      m = moment();
      dayMS = m.diff(moment().startOf('day'));
      console.log(dayMS);
      return function(model) {
        var res;
        res = m.diff(moment(model.createdAt));
        return res < dayMS;
      };
    })();
  };

  angular.module('manageApp').directive('pomodorolist', function() {
    return {
      templateUrl: "views/directives/pomodorolist.html",
      restrict: 'E',
      scope: true,
      controller: ['$scope', 'Pomodoro', controller]
    };
  });

}).call(this);

/*
//@ sourceMappingURL=pomodorolist.map
*/
