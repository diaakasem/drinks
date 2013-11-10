controller = (scope)->

  scope.drinks = [
    name: 'Espresso'
    description:'Coffee Drink'
    img: "http://placehold.it/50x50"
  ,
    name: 'Espresso'
    description:'Coffee Drink'
    img: "http://placehold.it/50x50"
  ,
    name: 'Espresso'
    description:'Coffee Drink'
    img: "http://placehold.it/50x50"
  ,
    name: 'Espresso'
    description:'Coffee Drink'
    img: "http://placehold.it/50x50"
  ,
    name: 'Espresso'
    description:'Coffee Drink'
    img: "http://placehold.it/50x50"
  ,
    name: 'Espresso'
    description:'Coffee Drink'
    img: "http://placehold.it/50x50"
  ,
    name: 'Espresso'
    description:'Coffee Drink'
    img: "http://placehold.it/50x50"
  ,
    name: 'Espresso'
    description:'Coffee Drink'
    img: "http://placehold.it/50x50"
  ,
    name: 'Espresso'
    description:'Coffee Drink'
    img: "http://placehold.it/50x50"
  ]


angular.module('drinksApp')
  .controller 'DrinkListCtrl',
  ['$scope', controller]
