// Generated by CoffeeScript 1.6.3
(function() {
  'use strict';
  describe('Filter: timer', function() {
    var timer;
    beforeEach(module('drinksApp'));
    timer = {};
    beforeEach(inject(function($filter) {
      return timer = $filter('timer');
    }));
    return it('should return the input prefixed with "timer filter:"', function() {
      var text;
      text = 'angularjs';
      return expect(timer(text)).toBe('timer filter: ' + text);
    });
  });

}).call(this);
