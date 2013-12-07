'use strict'

describe 'Controller: FitnessItemAddCtrl', () ->

  # load the controller's module
  beforeEach module 'manageApp'

  FitnessItemAddCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    FitnessItemAddCtrl = $controller 'FitnessItemAddCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
