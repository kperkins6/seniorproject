controllers = angular.module('controllers')
controllers.controller("TagController", [ '$scope', '$routeParams', '$resource', '$location', 'flash',
  ($scope,$routeParams,$resource,$location, flash)->
    Tag = $resource('/tags/:tagId', { tagId: "@id", format: 'json' },
      {
        'save':   {method:'PUT'},
        'create': {method:'POST'}
      }
    )

    if $routeParams.tagId
      Tag.get({tagId: $routeParams.tagId},
        ( (tag)-> $scope.tag = tag ),
        ( (httpResponse)->
          $scope.tag = null
          flash.error   = "There is no tag with ID #{$routeParams.tagId}"
        )
      )
    else
      $scope.tag = {}

    $scope.back   = -> $location.path("/")

    $scope.edit   = -> $location.path("/tags/#{$scope.tag.id}/edit")
    $scope.cancel = ->
      if $scope.tag.id
        $location.path("/tags/#{$scope.tag.id}")
      else
        $location.path("/")

    $scope.save = ->
      onError = (_httpResponse)-> flash.error = "Something went wrong"
      if $scope.tag.id
        $scope.tag.$save(
          ( ()-> $location.path("/tags/#{$scope.tag.id}") ),
          onError)
      else
        Tag.create($scope.tag,
          ( (newTag)-> $location.path("/tags/#{newTag.id}") ),
          onError
        )

    $scope.delete = ->
      $scope.tag.$delete()
      $scope.back()


])
