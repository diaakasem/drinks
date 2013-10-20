'use strict'

describe 'Controller: DrinkEditCtrl', () ->

  # load the controller's module
  beforeEach module 'drinksApp'

  DrinkEditCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    DrinkEditCtrl = $controller 'DrinkEditCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3;
