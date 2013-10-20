'use strict'

describe 'Controller: DrinkViewCtrl', () ->

  # load the controller's module
  beforeEach module 'drinksApp'

  DrinkViewCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    DrinkViewCtrl = $controller 'DrinkViewCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3;
