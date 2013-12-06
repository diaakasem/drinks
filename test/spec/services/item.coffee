'use strict'

describe 'Service: item', () ->

  # load the service's module
  beforeEach module 'manageApp'

  # instantiate service
  item = {}
  beforeEach inject (_item_) ->
    item = _item_

  it 'should do something', () ->
    expect(!!item).toBe true
