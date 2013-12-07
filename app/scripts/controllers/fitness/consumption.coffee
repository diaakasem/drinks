'use strict'
controller = (scope, ParseCrud)->
  Items = new ParseCrud 'Items'

  scope.error = scope.success = ''

  success = (res)->
    console.log res
    scope.$apply ->
      scope.entities = res

  error = (e)->
    console.log e
    scope.$apply ->
      scope.error = 'Error occured'
    
  Items.list success, error

angular.module('manageApp')
  .controller 'FitnessConsumptionCtrl',
  ['$scope', 'ParseCrud', controller]
