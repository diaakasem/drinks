'use strict';

angular.module('drinksApp')
  .directive('pomodorolist', () ->
    template: '<div></div>'
    restrict: 'E'
    link: (scope, element, attrs) ->
      element.text 'this is the pomodorolist directive'
  )
