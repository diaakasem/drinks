'use strict';

angular.module('drinksApp')
  .directive('drinks', () ->
    template: '<div></div>'
    restrict: 'E'
    link: (scope, element, attrs) ->
      element.text 'this is the drinks directive'
  )
