'use strict'

describe 'Directive: drinks', () ->
  beforeEach module 'drinksApp'

  element = {}

  it 'should make hidden element visible', inject ($rootScope, $compile) ->
    element = angular.element '<drinks></drinks>'
    element = $compile(element) $rootScope
    expect(element.text()).toBe 'this is the drinks directive'
