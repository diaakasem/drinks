filter = ->
  (input) ->
    console.log input
    input ?= 0
    "#{input}"
    
angular.module('drinksApp')
  .filter 'timer', filter
