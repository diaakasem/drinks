'use strict'

describe 'Controller: ContactsMailCtrl', () ->

  # load the controller's module
  beforeEach module 'drinksApp'

  ContactsMailCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ContactsMailCtrl = $controller 'ContactsMailCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
