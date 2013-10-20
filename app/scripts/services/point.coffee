service = ->
  crud().config "point"
angular.module('drinksApp')
  .factory 'Point',
    ['Crud', service]
