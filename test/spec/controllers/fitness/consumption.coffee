'use strict'

describe 'Controller: FitnessConsumptionCtrl', () ->

  # load the controller's module
  beforeEach module 'manageApp'

  FitnessConsumptionCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    FitnessConsumptionCtrl = $controller 'FitnessConsumptionCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
