'use strict'

describe 'Directive: pomodorolist', () ->

  # load the directive's module
  beforeEach module 'drinksApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<pomodorolist></pomodorolist>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the pomodorolist directive'
