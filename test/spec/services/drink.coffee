'use strict'

describe 'Service: drink', () ->

  # load the service's module
  beforeEach module 'drinksApp'

  # instantiate service
  drink = {}
  beforeEach inject (_drink_) ->
    drink = _drink_

  it 'should do something', () ->
    expect(!!drink).toBe true;
