'use strict'

describe 'Controller: PomodoroCtrl', () ->

  # load the controller's module
  beforeEach module 'drinksApp'

  PomodoroCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    PomodoroCtrl = $controller 'PomodoroCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
