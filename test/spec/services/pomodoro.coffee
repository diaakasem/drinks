'use strict'

describe 'Service: pomodoro', () ->

  # load the service's module
  beforeEach module 'drinksApp'

  # instantiate service
  pomodoro = {}
  beforeEach inject (_pomodoro_) ->
    pomodoro = _pomodoro_

  it 'should do something', () ->
    expect(!!pomodoro).toBe true;
