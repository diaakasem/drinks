controller = (scope) ->
  Contact = Parse.Object.extend 'Contact'

  scope.contacts = []
  scope.model =
    name: ''
    email: ''

  scope.load = ->
    query = new Parse.Query 'Contact'
    query.find
      success: (res)->
        scope.$apply ->
          scope.contacts = res

  scope.load()

  scope.add = (form)->
    contact = new Contact()
    contact.set 'name', scope.model.name
    contact.set 'email', scope.model.email
    contact.setACL(new Parse.ACL(Parse.User.current()))
    contact.save null,
      success: ->
        scope.load()
        scope.$apply ->
          scope.model.name = ''
          scope.model.email = ''
    

angular.module('manageApp')
  .controller 'ContactsCtrl',
  ['$scope', controller]
