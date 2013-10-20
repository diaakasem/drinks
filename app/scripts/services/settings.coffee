service = ->
  crud().config "settings"
angular.module('drinksApp')
  .factory 'Settings',
    ['Crud', service]
