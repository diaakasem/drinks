filter = -> _.str.capitalize

angular.module('drinksApp')
  .filter 'capital', filter
