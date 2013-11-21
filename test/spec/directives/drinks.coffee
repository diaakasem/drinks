'use strict'

describe 'Directive: manage', () ->
  beforeEach module 'manageApp'

  element = {}

  it 'should make hidden element visible', inject ($rootScope, $compile) ->
    element = angular.element '<manage></manage>'
    element = $compile(element) $rootScope
    expect(element.text()).toBe 'this is the manage directive'
