filter = -> _.str.capitalize

angular.module('manageApp')
  .filter 'capital', filter
