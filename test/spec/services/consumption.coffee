'use strict'

describe 'Service: consumption', () ->

  # load the service's module
  beforeEach module 'manageApp'

  # instantiate service
  consumption = {}
  beforeEach inject (_consumption_) ->
    consumption = _consumption_

  it 'should do something', () ->
    expect(!!consumption).toBe true
