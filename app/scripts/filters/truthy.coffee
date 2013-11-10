filter = () ->
  (input) ->
    if input then 'Yes' else 'No'

angular.module('drinksApp')
  .filter 'truthy', filter
