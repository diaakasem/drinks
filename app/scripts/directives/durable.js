// Generated by CoffeeScript 1.6.3
(function() {
  var controller, memoize, timeNow;

  timeNow = function() {
    return new Date().getTime();
  };

  memoize = function(fn, ttl) {
    var lastTime, m;
    lastTime = timeNow();
    m = _.memoize(fn);
    return function() {
      var now;
      now = timeNow();
      if (now - lastTime >= ttl) {
        lastTime = now;
        m.cache = {};
      }
      return m();
    };
  };

  controller = function(scope, timeout) {
    var count, everyPeriod, originalCount, pausesTime, play, runInterval, sounds, timePassed, timer;
    if (!scope.show) {
      return;
    }
    scope.mute = true;
    scope.name = scope.model.get('name');
    scope.tags = scope.model.get('tags');
    scope.save = function() {
      scope.model.set('name', scope.name);
      scope.model.set('tags', scope.tags);
      scope.model.save();
      return scope.editing = false;
    };
    timer = null;
    sounds = {
      tick: 'tickSound',
      crank: 'crankSound',
      alarm: 'alarmSound',
      current: null,
      last: null
    };
    play = function(song) {
      var _ref, _ref1, _ref2, _ref3, _ref4;
      if (song === (sounds.last != null)) {
        if ((_ref = sounds.current) != null) {
          _ref.currentTime = 0;
        }
        if ((_ref1 = sounds.current) != null ? _ref1.paused : void 0) {
          if ((_ref2 = sounds.current) != null) {
            _ref2.play();
          }
        }
      } else {
        if ((_ref3 = sounds.current) != null) {
          _ref3.pause();
        }
        sounds.last = song;
        sounds.current = document.getElementById(song);
      }
      if (song !== (sounds.last != null)) {
        return (_ref4 = sounds.current) != null ? _ref4.play() : void 0;
      }
    };
    pausesTime = (function() {
      var calcPauses, sum;
      calcPauses = function(p) {
        return p.end - p.start;
      };
      sum = function(x, y) {
        return x + y;
      };
      return function() {
        var currentPause, p, res;
        res = _.reduce(_.map(scope.model.get('pauses'), calcPauses), sum);
        if (res == null) {
          res = 0;
        }
        p = scope.model.get('pause');
        if (p != null ? p.start : void 0) {
          currentPause = timeNow() - p.start;
          res += currentPause;
        }
        return res || 0;
      };
    })();
    timePassed = function() {
      return (timeNow() - scope.model.createdAt - pausesTime()) / 1000;
    };
    if (timePassed() < 1) {
      play(sounds.crank);
    }
    originalCount = scope.model.get('sprint') + scope.model.get('rest');
    count = memoize(function() {
      if (scope.model.get('status') === 'done') {
        return 0;
      } else {
        return originalCount - timePassed();
      }
    }, 990);
    scope.getTime = memoize(function() {
      if (scope.model.get('status') !== 'done') {
        if (count() - scope.model.get('rest') > 0) {
          return count() - scope.model.get('rest');
        } else {
          return count();
        }
      } else {
        return 0;
      }
    }, 990);
    scope.anotherOne = function() {
      return scope.again()(scope.model);
    };
    everyPeriod = 1000;
    runInterval = function() {
      var pause, _ref, _ref1;
      timer = timeout(runInterval, everyPeriod);
      pause = scope.model.get('pause');
      if (!pause.start) {
        if (scope.model.get('status') !== 'done') {
          if (count() > 0) {
            if (!scope.mute) {
              play(sounds.tick);
            } else {
              if ((_ref = sounds.current) != null) {
                _ref.pause();
              }
            }
            if (scope.model.get('status') === 'work' && count() <= scope.model.get('rest')) {
              play(sounds.alarm);
              scope.model.set('status', 'rest');
              return scope.onChange()(scope.model);
            }
          } else {
            play(sounds.alarm);
            scope.model.set('status', 'done');
            return scope.onChange()(scope.model);
          }
        } else {
          timeout.cancel(timer);
          scope.onChange()(scope.model);
          return scope.onDone()(scope.model);
        }
      } else {
        return (_ref1 = sounds.current) != null ? _ref1.pause() : void 0;
      }
    };
    timeout(runInterval, everyPeriod);
    scope.doPause = function() {
      var pause, _ref;
      if ((_ref = sounds.current) != null) {
        _ref.pause();
      }
      pause = scope.model.get('pause');
      if (!(pause && pause.start)) {
        scope.model.set('pause', {
          start: timeNow(),
          end: undefined
        });
      } else {
        pause.end = timeNow();
        scope.model.add('pauses', pause);
        scope.model.set('pause', {});
      }
      return scope.onChange()(scope.model);
    };
    scope.doRemove = function() {
      var _ref;
      timeout.cancel(timer);
      scope.remove()(scope.model);
      return (_ref = sounds.current) != null ? _ref.pause() : void 0;
    };
    scope.$on('$routeChangeStart', function(next, current) {
      var _ref;
      timeout.cancel(timer);
      scope.onChange()(scope.model);
      return (_ref = sounds.current) != null ? _ref.pause() : void 0;
    });
    scope.whenDone = function(model) {
      return model.get('status') === 'done';
    };
    return $('.withtooltip').tooltip({});
  };

  angular.module('manageApp').directive('durable', function() {
    return {
      templateUrl: 'views/directives/durable.html',
      restrict: 'E',
      scope: {
        model: '=',
        onChange: '&change',
        remove: '&remove',
        show: '=',
        onDone: '&done',
        again: '&again'
      },
      replace: true,
      controller: ['$scope', '$timeout', controller]
    };
  });

}).call(this);

/*
//@ sourceMappingURL=durable.map
*/
