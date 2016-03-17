controllers = angular.module('controllers')
controllers.controller("BcardsController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.search = (keywords)->  $location.path("/bcards").search('keywords',keywords)
    Bcard = $resource('/bcards/:bcardId', { bcardId: "@id", format: 'json' })

    if $routeParams.keywords
      Bcard.query(keywords: $routeParams.keywords, (results)-> $scope.bcards = results)
    else
      $scope.bcards = []

    $scope.view = (bcardId)-> $location.path("/bcards/#{bcardId}")

    $scope.newBcard = -> $location.path("/bcards/new")
    $scope.edit      = (bcardId)-> $location.path("/bcards/#{bcardId}/edit")
])
