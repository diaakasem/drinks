'use strict'

describe 'Controller: FitnessResportsCtrl', () ->

  # load the controller's module
  beforeEach module 'manageApp'

  FitnessResportsCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    FitnessResportsCtrl = $controller 'FitnessResportsCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
