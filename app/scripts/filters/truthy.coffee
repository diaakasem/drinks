filter = () ->
  (input) ->
    if input then 'Yes' else 'No'

angular.module('manageApp')
  .filter 'truthy', filter
