'use strict'

describe 'Directive: doable', () ->
  beforeEach module 'drinksApp'

  element = {}

  it 'should make hidden element visible', inject ($rootScope, $compile) ->
    element = angular.element '<doable></doable>'
    element = $compile(element) $rootScope
    expect(element.text()).toBe 'this is the doable directive'
