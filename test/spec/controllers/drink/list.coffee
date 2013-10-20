'use strict'

describe 'Controller: DrinkListCtrl', () ->

  # load the controller's module
  beforeEach module 'drinksApp'

  DrinkListCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    DrinkListCtrl = $controller 'DrinkListCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3;
