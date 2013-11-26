controller = (scope)->
  scope.onSuccess = ->
    scope.go '/'

  scope.onError = ->
    scope.error = "Please, check your username and password."
    console.log scope.error

angular.module('manageApp')
  .controller 'SigninCtrl',
    ['$scope', controller]
