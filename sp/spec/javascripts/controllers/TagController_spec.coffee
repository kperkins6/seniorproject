describe "TagController", ->
  scope        = null
  ctrl         = null
  routeParams  = null
  httpBackend  = null
  flash        = null
  tagId        = 42

  fakeTag      =
    id: tagId
    text: "Baked Potatoes"
    hits: "20"

  setupController =(tagExists=true)->
    inject(($location, $routeParams, $rootScope, $httpBackend, $controller, _flash_)->
      scope       = $rootScope.$new()
      location    = $location
      httpBackend = $httpBackend
      routeParams = $routeParams
      routeParams.tagId = tagId
      flash = _flash_

      request = new RegExp("\/tags/#{tagId}")
      results = if tagExists
        [200,fakeTag]
      else
        [404]

      httpBackend.expectGET(request).respond(results[0],results[1])

      ctrl        = $controller('TagController',
                                $scope: scope)
    )

  beforeEach(module("sp"))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
    describe 'tag is found', ->
      beforeEach(setupController())
      it 'loads the given tag', ->
        httpBackend.flush()
        expect(scope.tag).toEqualData(fakeTag)
    describe 'tag is not found', ->
      beforeEach(setupController(false))
      it 'loads the given tag', ->
        httpBackend.flush()
        expect(scope.tag).toBe(null)
        expect(flash.error).toBe("There is no tag with ID #{tagId}")
