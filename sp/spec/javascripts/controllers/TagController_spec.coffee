describe "TagController", ->
  scope        = null
  ctrl         = null
  routeParams  = null
  httpBackend  = null
  flash        = null
  location     = null
  tagId        = 42

  fakeTag      =
    id: tagId
    text: "Baked Potatoes"
    hits: "20"

  setupController =(tagExists=true,tagId=42)->
    inject(($location, $routeParams, $rootScope, $httpBackend, $controller, _flash_)->
      scope       = $rootScope.$new()
      location    = $location
      httpBackend = $httpBackend
      routeParams = $routeParams
      routeParams.tagId = tagId if tagId
      flash = _flash_
      if tagId
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

  describe 'create', ->
    newTag =
      id: 42
      text: 'Toast'
      hits: '7'

    beforeEach ->
      setupController(false,false)
      request = new RegExp("\/tags")
      httpBackend.expectPOST(request).respond(201,newTag)

    it 'posts to the backend', ->
      scope.tag.text         = newTag.text
      scope.tag.hits = newTag.hits
      scope.save()
      httpBackend.flush()
      expect(location.path()).toBe("/tags/#{newTag.id}")

  describe 'update', ->
    updatedTag =
      text: 'Toast'
      hits: '7'

    beforeEach ->
      setupController()
      httpBackend.flush()
      request = new RegExp("\/tags")
      httpBackend.expectPUT(request).respond(204)

    it 'posts to the backend', ->
      scope.tag.text         = updatedTag.text
      scope.tag.hits = updatedTag.hits
      scope.save()
      httpBackend.flush()
      expect(location.path()).toBe("/tags/#{scope.tag.id}")

  describe 'delete' ,->
    beforeEach ->
      setupController()
      httpBackend.flush()
      request = new RegExp("\/tags/#{scope.tag.id}")
      httpBackend.expectDELETE(request).respond(204)

    it 'posts to the backend', ->
      scope.delete()
      httpBackend.flush()
      expect(location.path()).toBe("/")
