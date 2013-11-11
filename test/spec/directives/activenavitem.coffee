'use strict'

describe 'Directive: activenavitem', () ->
  beforeEach module 'drinksApp'

  element = {}

  it 'should make hidden element visible', inject ($rootScope, $compile) ->
    element = angular.element '<activenavitem></activenavitem>'
    element = $compile(element) $rootScope
    expect(element.text()).toBe 'this is the activenavitem directive'
