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

app = angular.module("drinksApp", ['ngRoute']).config config
app.run ->
  window.indexedDB = window.indexedDB || window.mozIndexedDB || window.webkitIndexedDB || window.msIndexedDB
  window.IDBTransaction = window.IDBTransaction || window.webkitIDBTransaction || window.msIDBTransaction
  window.IDBKeyRange = window.IDBKeyRange || window.webkitIDBKeyRange || window.msIDBKeyRange
  Parse.initialize("WSGMmizuVjklAI6SpdIMBypeDCzKPUAo05QpWUnV", "OVNmBrjWj4ggScDNvKf159pVQM89vyNTlRIOIh4u")
