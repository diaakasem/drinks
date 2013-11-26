controller = (scope, Service)->

  scope.entities = []

  Service.list (results)->
    scope.$apply ->
      scope.entities = results

  scope.remove = (model)->
    Service.remove model, ->
      scope.$apply ->
        scope.entities = _.filter scope.entities, (d)->
          d.id != model.id

  addCB = (result)->
    scope.$apply ->
      scope.entities.push result

  scope.add = ->
    Service.add addCB, scope.name

angular.module('manageApp')
  .controller 'IdeaListCtrl',
  ['$scope', 'Idea', controller]
