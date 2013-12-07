'use strict'
controller = (scope)->
  console.log scope.model

angular.module('manageApp')
  .directive 'item', () ->
    templateUrl: "views/directives/item.html"
    restrict: 'E'
    transclude: yes
    scope:
      model: '=model'
    controller: ['$scope', controller]
