describe "TagsController", ->
  scope        = null
  ctrl         = null
  location     = null
  routeParams  = null
  resource     = null
  httpBackend  = null

  setupController =(keywords,results)->
    inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      httpBackend = $httpBackend
      routeParams = $routeParams
      routeParams.keywords = keywords

      if results
        request = new RegExp("\/tags.*keywords=#{keywords}")
        httpBackend.expectGET(request).respond(results)

      ctrl        = $controller('TagsController',
                                $scope: scope
                                $location: location)
    )

  beforeEach(module("sp"))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
    describe 'when no keywords present', ->
      beforeEach(setupController())
      
      it 'defaults to no tags', ->
        expect(scope.tags).toEqualData([])

    describe 'with keywords', ->
      keywords = 'foo'
      tags = [
        {
          id: 2
          text: 'Baked Potatoes'
        },
        {
          id: 4
          text: 'Potatoes Au Gratin'
        }
      ]
      beforeEach ->
        setupController(keywords,tags)
        httpBackend.flush()

      it 'calls the back-end', ->
        expect(scope.tags).toEqualData(tags)

  describe 'search()', ->
    beforeEach ->
      setupController()

    it 'redirects to itself with a keyword param', ->
      keywords = 'foo'
      scope.search(keywords)
      expect(location.path()).toBe("/")
      expect(location.search()).toEqualData({keywords: keywords})
