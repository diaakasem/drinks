'use strict'

describe 'Directive: todolist', () ->
  beforeEach module 'drinksApp'

  element = {}

  it 'should make hidden element visible', inject ($rootScope, $compile) ->
    element = angular.element '<todolist></todolist>'
    element = $compile(element) $rootScope
    expect(element.text()).toBe 'this is the todolist directive'
