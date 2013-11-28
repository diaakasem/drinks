'use strict'

describe 'Controller: TodoCtrl', () ->

  # load the controller's module
  beforeEach module 'drinksApp'

  TodoCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    TodoCtrl = $controller 'TodoCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
