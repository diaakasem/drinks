// Generated by CoffeeScript 1.6.3
(function() {
  'use strict';
  describe('Filter: truthy', function() {
    var truthy;
    beforeEach(module('drinksApp'));
    truthy = {};
    beforeEach(inject(function($filter) {
      return truthy = $filter('truthy');
    }));
    return it('should return the input prefixed with "truthy filter:"', function() {
      var text;
      text = 'angularjs';
      return expect(truthy(text)).toBe('truthy filter: ' + text);
    });
  });

}).call(this);