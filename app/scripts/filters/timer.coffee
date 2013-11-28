filter = ->
  (input) ->
    if input > 60
      input /= 60.0
      input = Math.ceil input
    "#{parseInt(input, 10)}"
    
angular.module('manageApp')
  .filter 'timer', filter
