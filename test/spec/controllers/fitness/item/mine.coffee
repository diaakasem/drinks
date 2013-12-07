'use strict'

describe 'Controller: FitnessItemMineCtrl', () ->

  # load the controller's module
  beforeEach module 'manageApp'

  FitnessItemMineCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    FitnessItemMineCtrl = $controller 'FitnessItemMineCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
