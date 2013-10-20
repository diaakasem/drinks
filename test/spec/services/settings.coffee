'use strict'

describe 'Service: settings', () ->

  # load the service's module
  beforeEach module 'drinksApp'

  # instantiate service
  settings = {}
  beforeEach inject (_settings_) ->
    settings = _settings_

  it 'should do something', () ->
    expect(!!settings).toBe true;
