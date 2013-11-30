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
    scope.again = function(model) {
      scope.name = model.get('name');
      scope.tags = model.get('tags');
      return scope.add();
    };
    scope.showHistory = function(switchtab, cb) {
      if (switchtab == null) {
        switchtab = true;
      }
      if (switchtab) {
        scope.tab = 'history';
      }
      if (scope.history.length > 0) {
        return typeof cb === "function" ? cb(scope.history) : void 0;
      } else {
        return Service.list(new Date(now - dayMS), new Date(0), function(results) {
          return scope.$apply(function() {
            scope.history = results;
            return typeof cb === "function" ? cb(results) : void 0;
          });
        });
      }
    };
    scope.isBar = true;
    scope.buildGraph = function(data) {
      var chart;
      d3.select('svg g').remove();
      data = scope.buildData(scope.isBar, data);
      if (scope.isBar) {
        chart = nv.models.multiBarChart();
      } else {
        chart = nv.models.cumulativeLineChart().x(function(d) {
          return d[0];
        }).y(function(d) {
          return d[1];
        }).clipEdge(true);
      }
      chart.xAxis.axisLabel('Dates').tickFormat(function(d) {
        return moment(d).format('MMM Do');
      });
      chart.yAxis.axisLabel('Pomodoris').tickFormat(d3.format(",.1f"));
      d3.select("#reports svg").datum(data).transition().duration(500).call(chart);
      nv.utils.windowResize(chart.update);
      return chart;
    };
    scope.buildData = function(isBar, historyData) {
      var data;
      data = scope.entities.concat(historyData);
      data = _.groupBy(data, function(d) {
        return d.get('tags');
      });
      data = _.map(data, function(arr, tag) {
        var days, v;
        days = _.groupBy(arr, function(d) {
          return moment(d.createdAt).startOf('day').unix() * 1000;
        });
        v = _.map(days, function(pomodoros, day) {
          var count;
          count = pomodoros ? pomodoros.length : 0;
          day = parseInt(day);
          if (isBar) {
            return {
              x: day,
              y: count
            };
          } else {
            return [day, count];
          }
        });
        v = _.sortBy(v, function(d) {
          var ret;
          ret = isBar ? d.x : d[0];
          return ret;
        });
        return {
          key: tag,
          values: v
        };
      });
      data = _.sortBy(data, 'key');
      return data;
    };
    return scope.showReports = function() {
      var graph;
      scope.tab = 'reports';
      graph = function(historyData) {
        return scope.$watch('isBar', function(isBar) {
          return nv.addGraph(scope.buildGraph(historyData));
        });
      };
      if (scope.history.length > 0) {
        return graph(scope.history);
      } else {
        return scope.showHistory(false, graph);
      }
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
