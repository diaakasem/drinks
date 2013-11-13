'use strict'

describe 'Controller: IdeaListCtrl', () ->

  # load the controller's module
  beforeEach module 'drinksApp'

  IdeaListCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    IdeaListCtrl = $controller 'IdeaListCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3;
