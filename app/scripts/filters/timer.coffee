filter = ->
  (input) ->
    "#{input}"
    
angular.module('drinksApp')
  .filter 'timer', filter
