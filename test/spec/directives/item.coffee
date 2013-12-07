'use strict'

describe 'Directive: item', () ->

  # load the directive's module
  beforeEach module 'manageApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<item></item>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the item directive'
