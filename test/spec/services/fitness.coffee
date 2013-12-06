'use strict'

describe 'Service: fitness', () ->

  # load the service's module
  beforeEach module 'manageApp'

  # instantiate service
  fitness = {}
  beforeEach inject (_fitness_) ->
    fitness = _fitness_

  it 'should do something', () ->
    expect(!!fitness).toBe true
