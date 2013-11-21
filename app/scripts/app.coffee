config = ($routeProvider, $compileProvider) ->

  $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|ftp|mailto|chrome-extension):/)
  #$routeProvider.when("/",
    #templateUrl: "views/main.html"
    #controller: "MainCtrl"
  #)

  # Temporary
  $routeProvider.when '/', redirectTo: "/time/list"

  entities =
    'Drink':['Add', '_Edit', 'List', '_View']
    'Time':['List', '_View']
    'Cash':[]
    'Idea':['List']

  _.each entities, (pages, e)->
    le = e.toLowerCase()
    for p in pages
      id = if p[0] == '_' then '/:id'  else ''
      p = if p[0] == '_' then p.substring(1) else p
      lp = p.toLowerCase()
      $routeProvider.when "/#{le}/#{lp}#{id}",
        templateUrl: "views/#{le}/#{lp}.html"
        controller: "#{e}#{p}Ctrl"
  $routeProvider.when '/signin',
    templateUrl: 'views/signin.html',
    controller: 'SigninCtrl'

  $routeProvider.when '/signup',
    templateUrl: 'views/signup.html',
    controller: 'SignupCtrl'
  $routeProvider.otherwise redirectTo: '/'

dependencies = ['ui.bootstrap', 'ngRoute', 'dng.parse']
app = angular.module("manageApp", dependencies).config config
app.run ($rootScope, $location)->
  window.indexedDB = window.indexedDB || window.mozIndexedDB || window.webkitIndexedDB || window.msIndexedDB
  window.IDBTransaction = window.IDBTransaction || window.webkitIDBTransaction || window.msIDBTransaction
  window.IDBKeyRange = window.IDBKeyRange || window.webkitIDBKeyRange || window.msIDBKeyRange
  Parse.initialize("WSGMmizuVjklAI6SpdIMBypeDCzKPUAo05QpWUnV", "OVNmBrjWj4ggScDNvKf159pVQM89vyNTlRIOIh4u")
  $rootScope.go = (location)->
    $location.path location

