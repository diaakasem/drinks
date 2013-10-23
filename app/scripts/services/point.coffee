service = (Crud)->
  Crud().config "point"
  
angular.module('drinksApp')
  .factory 'Point',
    ['Crud', service]
