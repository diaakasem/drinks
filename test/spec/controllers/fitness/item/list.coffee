'use strict'

describe 'Controller: FitnessItemListCtrl', () ->

  # load the controller's module
  beforeEach module 'manageApp'

  FitnessItemListCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    FitnessItemListCtrl = $controller 'FitnessItemListCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
