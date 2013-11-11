config = ($routeProvider, $compileProvider) ->

  $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|ftp|mailto|chrome-extension):/)
  $routeProvider.when("/",
    templateUrl: "views/main.html"
    controller: "MainCtrl"
  )

  entities =
    'Drink':['Add', '_Edit', 'List', '_View']
    'Time':['List', '_View']
    'Cash':[]
    'Idea':[]

  _.each entities, (pages, e)->
    console.log e
    console.log pages
    le = e.toLowerCase()
    for p in pages
      id = if p[0] == '_' then '/:id'  else ''
      p = if p[0] == '_' then p.substring(1) else p
      lp = p.toLowerCase()
      console.log p
      $routeProvider.when "/#{le}/#{lp}#{id}",
        templateUrl: "views/#{le}/#{lp}.html"
        controller: "#{e}#{p}Ctrl"

  $routeProvider.otherwise redirectTo: "/"

app = angular.module("drinksApp", ['ngRoute']).config config
app.run ($rootScope, $location)->
  window.indexedDB = window.indexedDB || window.mozIndexedDB || window.webkitIndexedDB || window.msIndexedDB
  window.IDBTransaction = window.IDBTransaction || window.webkitIDBTransaction || window.msIDBTransaction
  window.IDBKeyRange = window.IDBKeyRange || window.webkitIDBKeyRange || window.msIDBKeyRange
  Parse.initialize("WSGMmizuVjklAI6SpdIMBypeDCzKPUAo05QpWUnV", "OVNmBrjWj4ggScDNvKf159pVQM89vyNTlRIOIh4u")
  $rootScope.go = (location)->
    $location.path location

