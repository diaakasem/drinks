filter = ->
  (input) ->
    "#{input}"
    
angular.module('manageApp')
  .filter 'timer', filter
