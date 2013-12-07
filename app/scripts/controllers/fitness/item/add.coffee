'use strict'
controller = (scope, ParseCrud)->
  Items = new ParseCrud 'Items'
  ItemsRepo = new ParseCrud 'ItemsRepo', no

  scope.error = scope.success = ''
  scope.model = {}
  scope.model.isPublic = no

  success = (res)->
    console.log res
    scope.$apply ->
      scope.success = 'Saved successfully.'
      if scope.model.isPublic
        scope.model.isPublic = no
        ItemsRepo.save scope.model, success, error
      scope.model.name = ''
      scope.model.brief = ''

  error = (e)->
    console.log e
    scope.$apply ->
      scope.success = 'Error occured'
    
  scope.save = (form)->
    Items.save scope.model, success, error

angular.module('manageApp')
  .controller 'FitnessItemAddCtrl',
  ['$scope', 'ParseCrud', controller]
