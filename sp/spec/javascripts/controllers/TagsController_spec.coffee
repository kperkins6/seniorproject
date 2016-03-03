describe "TagsController", ->
  scope        = null
  ctrl         = null
  location     = null
  routeParams  = null
  resource     = null

  setupController =(keywords)->
    inject(($location, $routeParams, $rootScope, $resource, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      routeParams = $routeParams
      routeParams.keywords = keywords

      ctrl        = $controller('TagsController',
                                $scope: scope
                                $location: location)
    )

  beforeEach(module("sp"))
  beforeEach(setupController())

  it 'defaults to no tags', ->
    expect(scope.tags).toEqualData([])
