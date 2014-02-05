_ = require('underscore')._
fs = require('fs')
nconf = require('../../lib/helper').nconf
common = require('../../lib/common')
AuthUtils = require('../../lib/utils/auth')

describe 'AuthUtils', ->

  beforeEach ->
    spyOn(common, 'log')
    spyOn(AuthUtils, 'prompt').andCallFake (callback)->
      callback(null, {client_id: 'foo', client_secret: 'bar', project_key: 'test'})
    spyOn(fs, 'existsSync').andReturn true
    spyOn(nconf, 'save').andCallFake (callback)-> callback(null)
    spyOn(nconf, 'load').andCallFake (callback)->
      callback(null, {client_id: 'foo', client_secret: 'bar', project_key: 'test'})

  it 'should save credentials', ->
    AuthUtils.save()
    expect(AuthUtils.prompt).toHaveBeenCalledWith(jasmine.any(Function))
    expect(nconf.save).toHaveBeenCalled()
    expect(nconf.load).toHaveBeenCalled()