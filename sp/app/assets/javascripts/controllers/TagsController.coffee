controllers = angular.module('controllers')
controllers.controller("TagsController", [ '$scope', '$routeParams', '$location', '$resource','flash'
  ($scope,$routeParams,$location,$resource,flash)->
    Tag = $resource('/tags/:tagId', { tagId: "@id", format: 'json' })

    Tag.get({tagId: $routeParams.tagId},
      ( (tag)-> $scope.tag = tag ),
      ( (httpResponse)->
        $scope.tag = null
        flash.error = "There is no tag with ID #{routeParams.tagId}"
      )
    )

    $scope.view = (tagId)-> $location.path("/recipes/#{tagId}")
    $scope.back = -> $location.path("/")
    $scope.search = (keywords)->  $location.path("/").search('keywords',keywords)
])
