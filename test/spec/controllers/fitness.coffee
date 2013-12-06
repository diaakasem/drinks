'use strict'

describe 'Controller: FitnessCtrl', () ->

  # load the controller's module
  beforeEach module 'drinksApp'

  FitnessCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    FitnessCtrl = $controller 'FitnessCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
