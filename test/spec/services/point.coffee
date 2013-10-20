'use strict'

describe 'Service: point', () ->

  # load the service's module
  beforeEach module 'drinksApp'

  # instantiate service
  point = {}
  beforeEach inject (_point_) ->
    point = _point_

  it 'should do something', () ->
    expect(!!point).toBe true;
