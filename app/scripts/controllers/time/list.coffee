controller = (scope)->
  scope.tab = 'pomodoro'

angular.module('manageApp')
  .controller 'TimeListCtrl',
  ['$scope', controller]
