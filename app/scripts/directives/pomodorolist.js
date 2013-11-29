// Generated by CoffeeScript 1.6.3
(function() {
  var controller;

  controller = function(scope, Service) {
    var dayMS, m, now;
    m = moment();
    dayMS = m.diff(moment().startOf('day'));
    scope.tab = 'today';
    scope.entities = [];
    scope.history = [];
    scope.name = '';
    scope.tags = '';
    now = new Date();
    Service.list(now, new Date(now - dayMS), function(results) {
      return scope.$apply(function() {
        console.log(results);
        return scope.entities = results;
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
          scope.name = '';
          return scope.tags = '';
        });
      };
      return Service.add(cb, scope.name, scope.tags);
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
        scope.tags = model.get('tags');
        return scope.add();
      }
    };
    return scope.showHistory = function() {
      scope.tab = 'history';
      return Service.list(new Date(now - dayMS), new Date(0), function(results) {
        return scope.$apply(function() {
          console.log(results);
          return scope.history = results;
        });
      });
    };
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
