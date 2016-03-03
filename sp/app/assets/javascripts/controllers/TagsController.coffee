controllers = angular.module('controllers')
controllers.controller("TagsController", [ '$scope', '$routeParams', '$location', '$resource', 'flash',
  ($scope,$routeParams,$location,$resource,flash)->
    $scope.search = (keywords)->  $location.path("/").search('keywords',keywords)
    Tag = $resource('/tags/:tagId', { tagId: "@id", format: 'json' })

    Tag.get({tagId: $routeParams.tagId},
      ( (recipe)-> $scope.tag = tag),
      ( (httpResponse)->
        $scope.tag = null
        flash.error = "There is no tag with ID #{$routeParams.tagId}"
       )
    )

    if $routeParams.keywords
      Tag.query(keywords: $routeParams.keywords, (results)-> $scope.tags = results)

    else
      $scope.tags = []
])

