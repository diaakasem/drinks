controller =  (scope) ->

  scope.statuses = ['created', 'done', 'working', 'paused']

  scope.update = (status)->
    scope.model.set 'status', status
    scope.onChange() scope.model

  scope.doRemove = ->
    scope.remove() scope.model


angular.module('manageApp')
  .directive 'doable', ->
    templateUrl: 'views/directives/doable.html'
    restrict: 'E'
    scope:
      model:'='
      onChange: '&change'
      remove: '&remove'
    replace: yes
    controller: ['$scope', controller]
