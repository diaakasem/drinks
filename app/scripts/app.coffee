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
    redirectTo: '/time/list'
  

  # Temporary

  entities =
    'Drink':['Add', '_Edit', 'List', '_View']
    'Time':['List', '_View']
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

  $routeProvider.otherwise redirectTo: '/'

dependencies = ['ui.bootstrap', 'ngRoute', 'dng.parse']
app = angular.module("manageApp", dependencies).config config

rootController = (root, location)->
  # Prevent iPad, iPhone bounce
  document.body.addEventListener 'touchmove', (e)->
    e.preventDefault()
  , no

  root.go = (url)->
    location.path('/' + url)

  root.$on '$routeChangeStart', (event, next)->
    if next.access isnt 'public' and not root.user
      root.go 'signin'

  if Parse.User.current()
    root.user = Parse.User.current()
  else
    root.user = null

app.run ['$rootScope', '$location', rootController]
