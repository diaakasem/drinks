controller = (scope)->
  scope.onSuccess = ->
    scope.go '/'

  scope.onError = (user, error)->
    scope.error = "Please, check your username and password."


angular.module('manageApp')
  .controller 'SignupCtrl',
    ['$scope', controller]
