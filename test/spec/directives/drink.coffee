'use strict'

describe 'Directive: drink', () ->
  beforeEach module 'drinksApp'

  element = {}

  it 'should make hidden element visible', inject ($rootScope, $compile) ->
    element = angular.element '<drink></drink>'
    element = $compile(element) $rootScope
    expect(element.text()).toBe 'this is the drink directive'
