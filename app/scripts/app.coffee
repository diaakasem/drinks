config = ($routeProvider, $compileProvider) ->

  Parse.initialize("WSGMmizuVjklAI6SpdIMBypeDCzKPUAo05QpWUnV",
                   "OVNmBrjWj4ggScDNvKf159pVQM89vyNTlRIOIh4u")

  $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|ftp|mailto|chrome-extension):/)
  #$routeProvider.when("/",
    #templateUrl: "views/main.html"
    #controller: "MainCtrl"
    #access: 'user'
  #)
  $routeProvider.when "/",
    redirectTo: '/pomodoro'
  

  # Temporary

  entities =
    #'Drink':['Add', '_Edit', 'List', '_View']
    #'Todo':[]
    'Cash':[]
    'Idea':['List']

  _.each entities, (pages, e)->
    le = e.toLowerCase()
    for p in pages
      # The underscore indicates path needs /:id appended
      id = if p[0] == '_' then '/:id'  else ''
      p = if p[0] == '_' then p.substring(1) else p
      lp = p.toLowerCase()
      $routeProvider.when "/#{le}/#{lp}#{id}",
        templateUrl: "views/#{le}/#{lp}.html"
        controller: "#{e}#{p}Ctrl"
        access: 'user'

  $routeProvider.when '/signin',
    templateUrl: 'views/signin.html',
    controller: 'SigninCtrl'
    access: 'public'

  $routeProvider.when '/signup',
    templateUrl: 'views/signup.html',
    controller: 'SignupCtrl'
    access: 'public'

  .when '/pomodoro',
    templateUrl: 'views/pomodoro.html',
    controller: 'PomodoroCtrl'
    access: 'user'

  .when '/todo',
    templateUrl: 'views/todo.html',
    controller: 'TodoCtrl'
    access: 'user'

  .when '/contacts',
    templateUrl: 'views/contacts.html',
    controller: 'ContactsCtrl'
    access: 'user'

  .when '/contacts/mail/:email',
    templateUrl: 'views/contacts/mail.html',
    controller: 'ContactsMailCtrl'
    access: 'user'

  .when '/fitness',
    redirectTo: '/fitness/consumption'

  .when '/fitness/item/mine',
    templateUrl: 'views/fitness/item/mine.html',
    controller: 'FitnessItemMineCtrl'
    access: 'user'

  .when '/fitness/item/add',
    templateUrl: 'views/fitness/item/add.html',
    controller: 'FitnessItemAddCtrl'
    access: 'user'

  .when '/fitness/item/list',
    templateUrl: 'views/fitness/item/list.html',
    controller: 'FitnessItemListCtrl'
    access: 'user'

  .when '/fitness/consumption',
    templateUrl: 'views/fitness/consumption.html',
    controller: 'FitnessConsumptionCtrl'
    access: 'user'

  .when '/fitness/reports',
    templateUrl: 'views/fitness/resports.html',
    controller: 'FitnessResportsCtrl'
    access: 'user'

  $routeProvider.otherwise redirectTo: '/'

dependencies = ['ui.bootstrap', 'ngRoute', 'dng.parse']
app = angular.module("manageApp", dependencies).config config

rootController = (root, location)->

  root.go = (url)->
    location.path('/' + url)

  root.user = Parse.User.current()

  root.$on '$routeChangeStart', (event, next)->
    if next.access isnt 'public' and not root.user
      root.go 'signin'


app.run ['$rootScope', '$location', rootController]
