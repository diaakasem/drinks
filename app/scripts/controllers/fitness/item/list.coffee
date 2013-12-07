'use strict'
controller = (scope, ParseCrud)->
  ItemsRepo = new ParseCrud 'ItemsRepo'

  scope.error = scope.success = ''
  scope.model = {}

  success = (res)->
    console.log res
    scope.$apply ->
      scope.$parent.entities = res

  error = (e)->
    console.log e
    scope.$apply ->
      scope.error = 'Error occured'
    
  ItemsRepo.list success, error

angular.module('manageApp')
  .controller 'FitnessItemListCtrl',
  ['$scope', 'ParseCrud', controller]
