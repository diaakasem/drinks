'use strict'

describe 'Controller: ContactsCtrl', () ->

  # load the controller's module
  beforeEach module 'drinksApp'

  ContactsCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ContactsCtrl = $controller 'ContactsCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
