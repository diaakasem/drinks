service = (Crud)->
  Crud().config "settings"
angular.module('drinksApp')
  .factory 'Settings',
    ['Crud', service]
