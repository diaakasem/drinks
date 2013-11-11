'use strict'

describe 'Directive: durable', () ->
  beforeEach module 'drinksApp'

  element = {}

  it 'should make hidden element visible', inject ($rootScope, $compile) ->
    element = angular.element '<durable></durable>'
    element = $compile(element) $rootScope
    expect(element.text()).toBe 'this is the durable directive'
