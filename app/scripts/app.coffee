config = ($routeProvider) ->
  $routeProvider.when("/",
    templateUrl: "views/main.html"
    controller: "MainCtrl"
  ).when('/drink/add',
    templateUrl: 'views/drink/add.html',
    controller: 'DrinkAddCtrl'
  ).when('/drink/edit',
    templateUrl: 'views/drink/edit.html',
    controller: 'DrinkEditCtrl'
  ).when('/drink/view',
    templateUrl: 'views/drink/view.html',
    controller: 'DrinkViewCtrl'
  ).when('/drink/list',
    templateUrl: 'views/drink/list.html',
    controller: 'DrinkListCtrl'
  ).otherwise redirectTo: "/"

angular.module("drinksApp", ['ngRoute']).config config
