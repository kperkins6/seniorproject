controllers = angular.module('controllers')
controllers.controller("TagsController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.search = (keywords)->  $location.path("/").search('keywords',keywords)
    Tag = $resource('/tags/:tagId', { tagId: "@id", format: 'json' })

    if $routeParams.keywords
      Tag.query(keywords: $routeParams.keywords, (results)-> $scope.tags = results)
    else
      $scope.tags = []

    $scope.view = (tagId)-> $location.path("/tags/#{tagId}")

    $scope.newTag = -> $location.path("/tags/new")
    $scope.edit      = (tagId)-> $location.path("/tags/#{tagId}/edit")
])
