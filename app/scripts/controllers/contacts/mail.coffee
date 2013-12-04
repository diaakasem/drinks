'use strict'
controller = (scope, params) ->
  
  scope.model =
    subject: ''
    content: ''
    email: params.email
  
  scope.send = ->
    Parse.Cloud.run 'mail', scope.model,
      success: (result)->
        alert result
      error: (error) ->
  

angular.module('manageApp')
  .controller 'ContactsMailCtrl',
  ['$scope', '$routeParams', controller]
