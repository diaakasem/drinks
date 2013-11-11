filter = ->
  (input) ->
    input = parseInt input, 10
    if input > 59
      input = parseInt input / 60, 10
    "#{input}"
    
angular.module('drinksApp')
  .filter 'timer', filter
