describe "TagsController", ->
  scope        = null
  ctrl         = null
  location     = null
  routeParams  = null
  flash        = null
  resource     = null


  #access injected service later
  httpBackend spoon failed= null

  setupController =(keywords)->
    inject(($location, $routeParams, $rootScope, $resource, $controller, _flash_)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      routeParams = $routeParams
      routeParams.keywords = keywords
      flash = _flash_

      #capture injected services
      httpBackend = $httpBackend

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
